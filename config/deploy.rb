require 'vlad/maintenance'
set :application, 'niarevo'
set :domain, 'dreamtagger.com'
set :deploy_to, "/home/wadsbone/dreamtagger.com"
set :repository, 'git://github.com/subakva/niarevo.git'

namespace :vlad do
  desc 'Sets up tools and sources for ruby gems'
  remote_task :setup_gems do
    run "gem install gemcutter"
    run "gem tumble"
    run "gem sources -a http://gems.github.com"
    run "gem install gemtronics"
  end

  desc 'Loads the seed data into the database'
  remote_task :seed_database do
    run "cd #{current_path} && rake db:seed"
  end

  desc 'Installs gems on the server using gemtronics'
  remote_task :install_gems do
    run "cd #{current_path} && gemtronics install production"
  end

  desc 'Create symlinks for config files'
  remote_task :create_symlinks do
    %w{
      config/database.yml
      config/configatron/production/credentials.rb
    }.each do |file_path|
      run "ln -s #{shared_path}/#{file_path} #{current_path}/#{file_path}"
    end
  end

  desc 'Runs all tasks to deploy the latest code'
  remote_task :deploy => [
    'maintenance:on',
    :update,
    :install_gems,
    :create_symlinks,
    :migrate,
    :start_app,
    'maintenance:off',
    :cleanup
  ]
end
