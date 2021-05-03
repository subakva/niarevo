# frozen_string_literal: true

require 'rack-timeout'

Rails.application.configure do
  config.middleware.insert_before(
    Rack::Runtime,
    Rack::Timeout,
    service_timeout: Integer(ENV['WEB_TIMEOUT'] || 15) # seconds
  )
end

Rack::Timeout::Logger.logger = Logger.new($stdout)
Rack::Timeout::Logger.level  = Logger::WARN
