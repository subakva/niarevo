# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "http://www.dreamtagger.com"
SitemapGenerator::Sitemap.yahoo_app_id = configatron.yahoo.app_id

SitemapGenerator::Sitemap.add_links do |sitemap|
  # Put links creation logic here.
  #
  # The root path '/' and sitemap index file are added automatically.
  # Links are added to the Sitemap in the order they are specified.
  #
  # Usage: sitemap.add path, options
  #        (default options are used if you don't specify)
  #
  # Defaults: :priority => 0.5, :changefreq => 'weekly',
  #           :lastmod => Time.zone.now, :host => default_host


  # Dream Listing Paths
  sitemap.add dreams_path,                  :changefreq => 'daily'
  sitemap.add untagged_dreams_path,         :changefreq => 'daily'
  sitemap.add untagged_context_dreams_path, :changefreq => 'daily'
  sitemap.add untagged_content_dreams_path, :changefreq => 'daily'

  Tag.find_each do |tag|
    sitemap.add tag_dreams_path(tag.name),  :changefreq => 'weekly'
    case tag.kind
    when 'content_tag'
      sitemap.add content_tag_dreams_path(tag.name),  :changefreq => 'weekly'
    when 'context_tag'
      sitemap.add context_tag_dreams_path(tag.name),  :changefreq => 'weekly'
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
