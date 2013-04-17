source 'https://rubygems.org'

ruby '2.0.0'

gem 'rails', '~>3.2.13'

gem 'pg'
gem 'foreigner'
gem 'newrelic_rpm'
gem 'airbrake'
gem 'unicorn'
gem 'rack-timeout'

gem 'jquery-rails'
gem 'slim-rails'

gem 'authlogic'
gem 'acts-as-taggable-on'
gem 'gravtastic'
gem 'strong_parameters'
gem 'rdiscount'
gem 'kaminari'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'less-rails'
  gem 'coffee-rails'
  gem 'blueprint-rails'

  gem 'therubyracer', :platforms => :ruby
  gem 'uglifier'
end

group :development, :test do
  gem 'rspec-rails'
  gem 'simplecov'
  gem 'factory_girl'
end

group :test do
  gem 'timecop'
end

group :development do
  gem 'quiet_assets'
  gem 'annotate'
  gem 'pry-debugger'
end

# Gems used for importing data from MySQL
group :import do
  gem 'activerecord-mysql-adapter'
  gem 'mysql2'
end
