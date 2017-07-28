require 'rack-timeout'

Rack::Timeout.timeout = Integer(ENV['WEB_TIMEOUT'] || 15) # seconds
Rack::Timeout::Logger.logger = Logger.new(STDOUT)
Rack::Timeout::Logger.level  = Logger::WARN
