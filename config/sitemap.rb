# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "http://www.dreamtagger.com"

SitemapGenerator::Sitemap.sitemaps_host = "http://s3.amazonaws.com/content.dreamtagger.com/"
SitemapGenerator::Sitemap.public_path = 'tmp/'
SitemapGenerator::Sitemap.sitemaps_path = 'sitemaps/'
SitemapGenerator::Sitemap.adapter = SitemapGenerator::S3Adapter.new

SitemapGenerator::Sitemap.add_links do |sitemap|

  # Dream Listing Paths
  sitemap.add dreams_path,                  :changefreq => 'daily'
  sitemap.add untagged_dreams_path,         :changefreq => 'daily'
  sitemap.add untagged_context_dreams_path, :changefreq => 'daily'
  sitemap.add untagged_content_dreams_path, :changefreq => 'daily'

  tag_sql = <<-SQL.squish
    select t.name, ts.context
    from taggings ts
    inner join tags t on t.id = ts.tag_id
    group by t.name, ts.context
  SQL

  ActsAsTaggableOn::Tagging.connection.select_rows(tag_sql).each do |name, context|
    sitemap.add tag_dreams_path(name),  :changefreq => 'weekly'
    case context
    when 'content_tags'
      sitemap.add content_tag_dreams_path(name),  :changefreq => 'weekly'
    when 'context_tags'
      sitemap.add context_tag_dreams_path(name),  :changefreq => 'weekly'
    else
      raise "Unknown tag context: #{context}"
    end
  end

  User.find_each do |user|
    sitemap.add user_dreams_path(user.username),      :changefreq => 'weekly'
  end

  from_date = Dream.find(:first, :order => 'created_at DESC').created_at
  to_date = Time.zone.now
  Range.new(from_date.year, to_date.year).each do |year|
    dreams_by_year_path(:year => year)
    Range.new(1, 12).each do |month|
      dreams_by_month_path(:year => year, :month => month)
      Range.new(1, ::Time.days_in_month(month, year)).each do |day|
        dreams_by_day_path(:year => year, :month => month, :day => day)
      end
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
