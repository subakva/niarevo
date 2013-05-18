source 'https://rubygems.org'

ruby '2.0.0'

gem 'rails', '~>4.0.0.rc1'

gem 'pg'            # postgresql db adapter
gem 'foreigner'     # foreign key support
gem 'newrelic_rpm'  # app monitoring
gem 'airbrake'      # error reporting
gem 'unicorn'       # app server
gem 'rack-timeout'  # kill slow responses

gem 'jquery-rails'                      # js library
gem 'slim-rails'                        # template system
gem 'less-rails-bootstrap'              # bootstrap css/js framework
gem 'lesselements-rails'                # additional less mixins
gem 'coffee-rails'                      # adds coffeescript support
gem 'font-awesome-rails'                # adds additional icons
gem 'therubyracer', :platforms => :ruby # v8 support for less
gem 'uglifier'                          # Javascript compressor

# Fixes deprecation warnings for Rails 4
gem 'authlogic', github: 'christophemaximin/authlogic', branch: 'fix_deprecated_with_scope'
gem 'acts-as-taggable-on'
gem 'gravtastic'                            # user images from gravatar
gem 'rdiscount'                             # markdown processor
gem 'kaminari'                              # pagination
gem 'recaptcha', require: 'recaptcha/rails' # captcha
gem 'sitemap_generator'                     # generates sitemaps for search engines
gem 'fog'                                   # For pushing sitemaps to S3

gem 'awesome_print' # Pretty output while debugging
gem 'pry'           # Better REPL

# Heroku compatibility
gem 'rails_log_stdout',           github: 'heroku/rails_log_stdout'
gem 'rails3_serve_static_assets', github: 'heroku/rails3_serve_static_assets'
gem 'yui-compressor'

group :development, :test do
  gem 'rspec-rails'
  gem 'factory_girl'

  gem 'capybara'
  gem 'capybara-email'
  gem 'poltergeist'
  gem 'launchy'
  gem 'jasminerice', github: 'bradphelan/jasminerice' # Using master for Rails 4

  gem 'simplecov'
  gem 'cane'
  gem 'morecane'
end

group :test do
  gem 'database_cleaner'
  gem 'timecop'
end

group :development do
  gem 'quiet_assets'
  gem 'annotate'
  gem 'pry-debugger'

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
  gem 'sdoc', require: false
end
