source 'https://rubygems.org'

ruby '2.0.0'

gem 'rails', '~>4.0.0.rc1'

gem 'pg'
gem 'foreigner'
gem 'newrelic_rpm'
gem 'airbrake'
gem 'unicorn'
gem 'rack-timeout'

gem 'jquery-rails'
gem 'slim-rails'

# Fixes deprecation warnings for Rails 4
gem 'authlogic', github: 'christophemaximin/authlogic', branch: 'fix_deprecated_with_scope'
gem 'acts-as-taggable-on', github: 'mbleigh/acts-as-taggable-on' # Using master for Rails 4
gem 'gravtastic'
gem 'rdiscount'
gem 'kaminari'
gem 'recaptcha', require: 'recaptcha/rails'
gem 'sitemap_generator'
gem 'fog' # For pushing sitemaps to S3

gem 'less-rails-bootstrap'
gem 'lesselements-rails'
gem 'coffee-rails'
gem 'font-awesome-rails'

gem 'therubyracer', :platforms => :ruby
gem 'uglifier'

gem 'pry' # For console magic.

group :development, :test do
  gem 'rspec-rails'
  gem 'factory_girl'

  gem 'capybara'
  gem 'capybara-email'
  gem 'launchy'
  gem 'jasminerice', github: 'bradphelan/jasminerice' # Using master for Rails 4

  gem 'simplecov'
  gem 'cane'
  gem 'morecane'
end

group :test do
  gem 'database_cleaner', github: 'bmabey/database_cleaner' # Using master for Rails 4
  gem 'timecop'
end

group :development do
  gem 'quiet_assets'
  gem 'annotate'
  gem 'pry-debugger'
  gem 'awesome_print'

  gem 'guard-rspec'
  gem 'guard-jasmine'
  gem 'rb-fsevent'
end

# Gems used for importing data from MySQL
group :import do
  gem 'activerecord-mysql-adapter'
  gem 'mysql2'
end

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end
