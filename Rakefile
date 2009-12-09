# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require(File.join(File.dirname(__FILE__), 'config', 'boot'))

require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'

require 'tasks/rails'

begin
  require 'vlad'
  Vlad.load :scm => :git
rescue LoadError => e
  puts "e = #{e}<br/>"
  # do nothing
end

require 'sitemap_generator/tasks' rescue LoadError

task :default => ['db:test:prepare', 'rcov:all']
