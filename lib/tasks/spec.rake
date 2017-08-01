# frozen_string_literal: true

require 'slim_lint/rake_task'
SlimLint::RakeTask.new

require 'rubocop/rake_task'
RuboCop::RakeTask.new

namespace :spec do
  desc 'Runs specs with coverage and cane checks'
  task quality: %w[cane slim_lint rubocop]
end

Rake::Task['spec'].enhance do
  Rake::Task['spec:quality'].invoke
end
