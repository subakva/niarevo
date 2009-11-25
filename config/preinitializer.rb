require 'rubygems'
require 'gemtronics'

Gemtronics.load
Gemtronics.find_and_require_gem('configatron')
Configatron::Rails.init
