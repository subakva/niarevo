if ENV['RAILS_ENV'] == 'production'
  ENV['GEM_PATH'] = File.expand_path('~/.gems') + ':/usr/lib/ruby/gems/1.8'
  RAILS_ENV = 'production'
end
  
require 'rubygems'
require 'gemtronics'

Gemtronics.load
Gemtronics.find_and_require_gem('configatron')
Configatron::Rails.init
