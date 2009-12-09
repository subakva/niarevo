if !defined?(RAILS_ENV) && ENV['RAILS_ENV']
  RAILS_ENV = ENV['RAILS_ENV']
end
  
require 'rubygems'
require 'gemtronics'

Gemtronics.load
Gemtronics.find_and_require_gem('configatron')
Configatron::Rails.init
