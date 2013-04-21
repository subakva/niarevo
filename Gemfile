source 'https://rubygems.org'

ruby '2.0.0'

gem 'rails', '~>3.2.13'

gem 'pg'
gem 'foreigner'
gem 'newrelic_rpm'
gem 'airbrake'
gem 'unicorn'
gem 'rack-timeout'

# gem 'jquery-rails'
gem 'slim-rails'

gem 'authlogic'
gem 'acts-as-taggable-on'
gem 'gravtastic'
gem 'strong_parameters'
gem 'rdiscount'
gem 'kaminari'
gem 'recaptcha', require: 'recaptcha/rails'
gem 'sitemap_generator'
gem 'fog'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'less-rails'
  gem 'coffee-rails'
  # gem 'blueprint-rails'

  gem 'therubyracer', :platforms => :ruby
  gem 'uglifier'
end

group :development, :test do
  gem 'rspec-rails'
  gem 'factory_girl'

  gem 'capybara'
  gem 'capybara-email'
  gem 'launchy'
  gem 'jasminerice'

  gem 'simplecov'
  gem 'cane'
  gem 'morecane'
end

group :test do
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
