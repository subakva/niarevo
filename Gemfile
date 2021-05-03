# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

ruby '2.7.2'

gem 'rails', '~>5.1.0'

gem 'scout_apm'     # app monitoring (must be before airbrake: https://github.com/elastic/apm-agent-ruby/issues/753)

gem 'airbrake'      # error reporting
gem 'pg'            # postgresql db adapter
gem 'puma'          # app server
gem 'rack-timeout', require: "rack/timeout/base" # kill slow responses
gem 'redis-rails'   # redis for caching, etc.

gem 'bootstrap-sass'                    # bootstrap/sass framework
gem 'coffee-rails'                      # adds coffeescript support
gem 'font-awesome-sass'                 # adds additional icons
gem 'sass-rails'                        # scss stylesheet preprocessor
gem 'slim-rails'                        # template system
gem 'uglifier'                          # Javascript compressor
gem 'webpacker'                         # Trigger yarn on heroku

gem 'authlogic'                             # user auth, activation, etc.
gem 'dotenv-rails'                          # autoload env variables from .env
gem 'fog-aws'                               # For pushing sitemaps to S3
gem 'gravtastic'                            # user images from gravatar
gem 'kaminari'                              # pagination
gem 'rdiscount'                             # markdown processor
gem 'recaptcha', require: 'recaptcha/rails' # captcha
gem 'sitemap_generator'                     # generates sitemaps for search engines
gem 'unf'                                   # For encoding AWS strings

gem 'awesome_print' # Pretty output while debugging

group :production do
  gem 'rails_12factor' # heroku logging, assets, etc.
end

group :development, :test do
  gem 'cane'
  gem 'capybara'
  gem 'capybara-email'
  gem 'factory_bot'
  gem 'launchy'
  gem 'morecane'
  gem 'poltergeist'
  gem 'pry-byebug'
  gem 'pry-remote'
  gem 'rspec-rails'
  gem 'rubocop'
  gem 'rubocop-rails', require: false
  gem 'simplecov', require: false
  gem 'slim_lint'
end

group :test do
  gem 'database_cleaner'
  gem 'fuubar'
  gem 'shoulda-matchers'
end

group :development do
  gem 'annotate'
  gem 'listen'
  gem 'pry-rails'
  gem 'spring'
  gem 'spring-commands-rspec'
  gem 'spring-watcher-listen'
  gem 'web-console'
end
