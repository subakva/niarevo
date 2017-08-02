# frozen_string_literal: true

begin
  require 'slim_lint/rake_task'
  SlimLint::RakeTask.new
rescue LoadError
  warn "slim_lint not available, task not provided."
  task :slim_lint
end

begin
  require 'rubocop/rake_task'
  RuboCop::RakeTask.new
rescue LoadError
  warn "rubocop not available, task not provided."
  task :rubocop
end

namespace :spec do
  desc 'Runs specs with coverage and cane checks'
  task quality: %w[cane slim_lint rubocop]
end

Rake::Task['spec'].enhance do
  Rake::Task['spec:quality'].invoke
end
