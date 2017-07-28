source 'https://rubygems.org'
git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

ruby '2.2.7'

gem 'rails', '~>4.0.0'

gem 'airbrake'      # error reporting
gem 'foreigner'     # foreign key support
gem 'newrelic_rpm'  # app monitoring
gem 'pg'            # postgresql db adapter
gem 'puma'          # app server
gem 'rack-timeout'  # kill slow responses

gem 'coffee-rails'                      # adds coffeescript support
gem 'font-awesome-rails', '~>3.0'       # adds additional icons
gem 'jquery-rails'                      # js library
gem 'less-rails-bootstrap'              # bootstrap css/js framework
gem 'slim-rails'                        # template system
gem 'therubyracer'                      # v8 support for less
gem 'uglifier'                          # Javascript compressor
gem 'yui-compressor'                    # CSS Compressor

gem 'acts-as-taggable-on'
gem 'authlogic', github: 'binarylogic/authlogic'
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
  gem 'jasminerice', github: 'bradphelan/jasminerice' # Using master for Rails 4
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
  gem 'annotate'
  gem 'quiet_assets'
  gem 'rb-fsevent'

  gem 'guard-jasmine'
  gem 'guard-rspec'
end
