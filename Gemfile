source 'https://rubygems.org'
git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

ruby '2.2.7'

gem 'rails', '~>4.1.0'

gem 'airbrake'      # error reporting
gem 'foreigner'     # foreign key support
gem 'scout_apm'     # app monitoring
gem 'pg'            # postgresql db adapter
gem 'puma'          # app server
gem 'rack-timeout'  # kill slow responses
gem 'redis-rails'   # redis for caching, etc.

gem 'bootstrap-sass'                    # bootstrap/sass framework
gem 'coffee-rails'                      # adds coffeescript support
gem 'font-awesome-sass'                 # adds additional icons
gem 'jquery-rails'                      # js library
gem 'sass-rails'                        # scss stylesheet preprocessor
gem 'slim-rails'                        # template system
gem 'uglifier'                          # Javascript compressor

gem 'acts-as-taggable-on'                   # tagging system
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
gem 'pry'           # Better REPL

group :production do
  gem 'rails_12factor' # heroku logging, assets, etc.
end

group :development, :test do
  gem 'cane'
  gem 'capybara'
  gem 'capybara-email'
  gem 'factory_girl'
  gem 'launchy'
  gem 'morecane'
  gem 'poltergeist'
  gem 'rspec-rails'
  gem 'simplecov'
end

group :test do
  gem 'database_cleaner'
  gem 'timecop'
end

group :development do
  gem 'spring'
  gem 'spring-commands-rspec'
  gem 'annotate'
  gem 'quiet_assets'
end
