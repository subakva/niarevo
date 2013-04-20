require 'simplecov'

class SimpleCov::Formatter::QualityFormatter
  def format(result)
    SimpleCov::Formatter::HTMLFormatter.new.format(result)
    File.open("coverage/covered_percent", "w") do |f|
      f.puts result.source_files.covered_percent.to_f
    end
  end
end

module SimpleCovHelper
  def start_simple_cov
    SimpleCov.start do
      formatter SimpleCov::Formatter::QualityFormatter
      add_filter '/spec/'
      add_filter '/config/'
      add_filter '/vendor/'
      add_group  'Models', 'app/models'
      add_group  'Controllers', 'app/controllers'
      add_group  'Helpers', 'app/helpers'
      add_group  'Views', 'app/views'
      add_group  'Mailers', 'app/mailers'
    end
  end
end

if ENV['COVERAGE']
  include SimpleCovHelper
  start_simple_cov
end
