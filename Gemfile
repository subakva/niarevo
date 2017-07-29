source 'https://rubygems.org'
git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

ruby '2.3.4'

gem 'rails', '~>5.0.0'

gem 'airbrake'      # error reporting
gem 'pg'            # postgresql db adapter
gem 'puma'          # app server
gem 'rack-timeout'  # kill slow responses
gem 'redis-rails'   # redis for caching, etc.
gem 'scout_apm'     # app monitoring

gem 'bootstrap-sass'                    # bootstrap/sass framework
gem 'coffee-rails'                      # adds coffeescript support
gem 'font-awesome-sass'                 # adds additional icons
gem 'jquery-rails'                      # js library
gem 'sass-rails'                        # scss stylesheet preprocessor
gem 'slim-rails'                        # template system
gem 'uglifier'                          # Javascript compressor

gem 'acts-as-taggable-on', '~>4.0'          # tagging system
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
  gem 'factory_girl'
  gem 'launchy'
  gem 'morecane'
  gem 'poltergeist'
  gem 'pry-byebug'
  gem 'pry-remote'
  gem 'rspec-rails'
  gem 'simplecov'
end

group :test do
  gem 'database_cleaner'
  gem 'fuubar'
  gem 'shoulda-matchers'
  gem 'timecop'
end

group :development do
  gem 'annotate'
  gem 'pry-rails'
  gem 'spring'
  gem 'spring-commands-rspec'
  gem 'web-console'
end
