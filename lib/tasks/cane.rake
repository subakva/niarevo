# frozen_string_literal: true

begin
  require 'cane/rake_task'
  require 'morecane'

  desc "Run cane to check quality metrics"
  Cane::RakeTask.new(:cane) do |cane|
    cane.add_threshold 'tmp/coverage/.last_run.json', :>=, 95
    cane.no_style = true
    cane.no_doc = true # Change to false to enable documentation checks
    cane.abc_max = 15 # Fail the build if complexity is too high.
    # cane.abc_exclude = %w(
    #   User#bad_code_rising
    # )
    # Fail the build if the code includes debugging statements
    cane.use Morecane::MustNotMatchCheck,
      must_not_match_glob: "{app,lib,config,spec}/**/*.rb",
      must_not_match_regexp: /binding\.pry|binding\.remote_pry|debugger|byebug/

    # Fail the build if anything tries to use the system time zone.
    cane.use Morecane::MustNotMatchCheck,
      must_not_match_glob: "{app,lib,config,spec}/**/*.rb",
      must_not_match_regexp: /(Time\.now|Time\.parse|Date\.parse)/
  end
rescue LoadError
  warn "cane not available, quality task not provided."
end
