require 'vlad/maintenance'

set :application, 'niarevo'
set :repository, 'git://github.com/subakva/niarevo.git'

namespace :vlad do
  desc 'Require an environment'
  task :require_deploy_env do
    if ENV['to']
      Kernel.load "config/deploy_#{ENV['to']}.rb"
    else
      raise RuntimeError.new("\nDeploy to which environment? ex. rake vlad:deploy to=production\n\n")
    end
  end

  desc 'Sets up tools and sources for ruby gems'
  remote_task :setup_gems => :require_deploy_env do
    sudo "/opt/ruby/bin/gem install gemcutter"
    sudo "/opt/ruby/bin/gem tumble"
    sudo "/opt/ruby/bin/gem sources -a http://gems.github.com"
    sudo "/opt/ruby/bin/gem install gemtronics"
  end

  desc 'Loads the seed data into the database'
  remote_task :seed_database => :require_deploy_env do
    run "cp #{shared_path}/config/dreamtagger-export.json #{current_path}/db/seeds/"
    run "cd #{current_path} && rake db:seed"
  end

  desc 'Installs gems on the server using gemtronics'
  remote_task :install_gems => :require_deploy_env do
    run "cd #{current_path} && sudo /opt/ruby/bin/gemtronics install"
  end

  desc 'Create symlinks for config files'
  remote_task :create_symlinks => :require_deploy_env do
    %w{
      config/database.yml
      config/configatron/production/credentials.rb
    }.each do |file_path|
      run "ln -s #{shared_path}/#{file_path} #{current_path}/#{file_path}"
    end
  end

  desc 'Restart Passenger'
  remote_task :restart_app => :require_deploy_env do
    run "touch #{current_path}/tmp/restart.txt"
  end

  desc 'Runs all tasks to deploy the latest code'
  remote_task :deploy => [
    :require_deploy_env,
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
