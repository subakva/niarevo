source 'https://rubygems.org'

ruby '2.0.0'

gem 'rails', '~>4.0.0.rc1'
# gem 'rails', '~>3.2.13'

gem 'pg'
gem 'foreigner'
gem 'newrelic_rpm'
gem 'airbrake'
gem 'unicorn'
gem 'rack-timeout'

gem 'jquery-rails'
gem 'slim-rails'

gem 'authlogic'
gem 'acts-as-taggable-on', github: 'mbleigh/acts-as-taggable-on' # Using master for Rails 4
gem 'gravtastic'
gem 'rdiscount'
gem 'kaminari'
gem 'recaptcha', require: 'recaptcha/rails'
gem 'sitemap_generator'
gem 'fog'

gem 'less-rails-bootstrap'
gem 'lesselements-rails'
gem 'coffee-rails'
gem 'font-awesome-rails'

gem 'therubyracer', :platforms => :ruby
gem 'uglifier'

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
