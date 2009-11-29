Gemtronics.find_and_require_gem('bmabey-email_spec')
require 'email_spec/cucumber'

Gemtronics.find_and_require_gem('fakeweb')
FakeWeb.allow_net_connect = false

Gemtronics.find_and_require_gem('thoughtbot-factory_girl')
require File.join(File.dirname(__FILE__), '..', '..', 'spec','support', 'factories')
