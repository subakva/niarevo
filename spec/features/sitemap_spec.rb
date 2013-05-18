require 'spec_helper'
require 'zlib'

feature 'Sitemap' do
  let(:sitemap_path) { File.join(Rails.root, 'tmp', 'sitemaps', 'sitemap.xml.gz') }
  let!(:dream) { FactoryGirl.create(:dream) }

  scenario "generating a sitemap" do
    silence_stream(STDOUT) { SitemapGenerator::Interpreter.run }
    doc = load_sitemap_doc

    # Generic dream list paths
    expect(doc).to have_mapped_url(dreams_url,                  changefreq: 'daily')
    expect(doc).to have_mapped_url(untagged_dreams_url,         changefreq: 'daily')
    expect(doc).to have_mapped_url(untagged_dream_dreams_url,   changefreq: 'daily')
    expect(doc).to have_mapped_url(untagged_dreamer_dreams_url, changefreq: 'daily')

    # Meta-content paths
    expect(doc).to have_mapped_url(zeitgeist_url, priority: 0.7, changefreq: 'daily')
    expect(doc).to have_mapped_url(about_url,     priority: 0.7, changefreq: 'yearly')
    expect(doc).to have_mapped_url(feeds_url,     priority: 0.7, changefreq: 'yearly')
    expect(doc).to have_mapped_url(terms_url,     priority: 0.3, changefreq: 'yearly')

    # Account-related paths
    expect(doc).to have_mapped_url(new_user_session_url,    priority: 0.3, changefreq: 'yearly')
    expect(doc).to have_mapped_url(new_account_url,         priority: 0.3, changefreq: 'yearly')
    expect(doc).to have_mapped_url(new_password_reset_url,  priority: 0.3, changefreq: 'yearly')
    expect(doc).to have_mapped_url(new_activation_url,      priority: 0.3, changefreq: 'yearly')

    # Dreams by user
    expect(doc).to have_mapped_url(user_dreams_url(dream.user.username), changefreq: 'weekly')

    # Dreams by year, month, and day
    dream_date = dream.created_at
    expect(doc).to have_mapped_url(
      dreams_by_year_url(year: dream_date.year), changefreq: 'weekly'
    )
    expect(doc).to have_mapped_url(
      dreams_by_month_url(year: dream_date.year, month: dream_date.month),
      changefreq: 'weekly'
    )
    # TODO: Include day links only for dates with content
    expect(doc).to_not have_mapped_url(
      dreams_by_day_url(year: dream_date.year, month: dream_date.month, day: dream_date.day),
      changefreq: 'weekly'
    )

    # Dream and tag-specific URLs
    expect(doc).to have_mapped_url(dream_url(dream), lastmod: dream.updated_at)
    dream.dream_tag_list.each do |name|
      expect(doc).to have_mapped_url(dream_tag_dreams_url(name), changefreq: 'weekly')
    end
    dream.dreamer_tag_list.each do |name|
      expect(doc).to have_mapped_url(dreamer_tag_dreams_url(name), changefreq: 'weekly')
    end
  end

  def load_sitemap_doc
    sitemap = ""
    Zlib::GzipReader.open(sitemap_path) { |f| sitemap << f.read }
    Nokogiri::XML::Document.parse(sitemap)
  end
end