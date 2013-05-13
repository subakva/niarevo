# Set the host name for URL creation
# SitemapGenerator::Sitemap.default_host = "http://www.dreamtagger.com"
SitemapGenerator::Sitemap.default_host = ENV['SITEMAP_HOST'] || 'http://www.dreamtagger.com'

SitemapGenerator::Sitemap.public_path = 'tmp/'
SitemapGenerator::Sitemap.sitemaps_path = 'sitemaps/'

unless Rails.env.test?
  SitemapGenerator::Sitemap.sitemaps_host = "http://s3.amazonaws.com/content.dreamtagger.com/"
  SitemapGenerator::Sitemap.adapter = SitemapGenerator::S3Adapter.new
end

SitemapGenerator::Sitemap.add_links do |sitemap|

  # Dream Listing Paths
  sitemap.add dreams_path,                  :changefreq => 'daily'
  sitemap.add untagged_dreams_path,         :changefreq => 'daily'
  sitemap.add untagged_dreamer_dreams_path, :changefreq => 'daily'
  sitemap.add untagged_dream_dreams_path,   :changefreq => 'daily'

  tag_sql = <<-SQL.squish
    SELECT t.name, ts.context
    FROM taggings ts
    INNER JOIN tags t ON t.id = ts.tag_id
    GROUP BY t.name, ts.context
  SQL

  ActsAsTaggableOn::Tagging.connection.select_rows(tag_sql).each do |name, context|
    sitemap.add tag_dreams_path(name),  :changefreq => 'weekly'
    case context
    when 'dream_tags'
      sitemap.add dream_tag_dreams_path(name),  :changefreq => 'weekly'
    when 'dreamer_tags'
      sitemap.add dreamer_tag_dreams_path(name),  :changefreq => 'weekly'
    else
      raise "Unknown tag context: #{context}"
    end
  end

  User.find_each do |user|
    sitemap.add user_dreams_path(user.username),      :changefreq => 'weekly'
  end

  to_date = Time.zone.now
  from_date = Dream.order('created_at DESC').first.try(:created_at) || to_date
  Range.new(from_date.year, to_date.year).each do |year|
    sitemap.add dreams_by_year_path(:year => year),      :changefreq => 'weekly'
    Range.new(1, 12).each do |month|
      sitemap.add dreams_by_month_path(:year => year, :month => month),      :changefreq => 'weekly'
      # TODO: Include day links only for dates with content
      # Range.new(1, ::Time.days_in_month(month, year)).each do |day|
      #   sitemap.add dreams_by_day_path(:year => year, :month => month, :day => day),      :changefreq => 'weekly'
      # end
    end
  end

  Dream.find_each do |d|
    sitemap.add dream_path(d), :lastmod => d.updated_at
  end

  # Meta-content paths
  sitemap.add zeitgeist_path, :priority => 0.7, :changefreq => 'daily'
  sitemap.add about_path, :priority => 0.7, :changefreq => 'yearly'
  sitemap.add feeds_path, :priority => 0.7, :changefreq => 'yearly'

  # Account-related paths
  sitemap.add new_user_session_path,    :priority => 0.3, :changefreq => 'yearly'
  sitemap.add new_account_path,         :priority => 0.3, :changefreq => 'yearly'
  sitemap.add new_password_reset_path,  :priority => 0.3, :changefreq => 'yearly'
  sitemap.add new_activation_path,      :priority => 0.3, :changefreq => 'yearly'

  # Legalese paths
  sitemap.add terms_path, :priority => 0.3, :changefreq => 'yearly'
end
