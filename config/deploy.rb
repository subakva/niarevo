require 'vlad/maintenance'

set :application, 'niarevo'
set :repository, 'git://github.com/subakva/niarevo.git'
# set :web_command, 'sudo /etc/init.d/nginx'
# set :ssh_flags, ['-t']
# set :ssh_flags, ['-t','-t']
# set :sudo_prompt, /\[sudo\] password for [\w]+:/
# set :sudo_prompt, /\[sudo\] password for [\w]+:/

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
    sudo "/opt/ruby/bin/gem sources -a http://gemcutter.org"
    sudo "/opt/ruby/bin/gem sources -a http://gems.github.com"
    sudo "/opt/ruby/bin/gem install gemtronics"
  end

  desc 'Loads the seed data into the database'
  remote_task :seed_database => :require_deploy_env do
    run "cp #{shared_path}/config/dreamtagger-export.json #{current_path}/db/seeds/"
    run "cd #{current_path} && /opt/ruby/bin/rake db:seed"
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

  desc 'Generate Sitemap'
  remote_task :generate_sitemap => :require_deploy_env do
    run "cd #{current_path} && RAILS_ENV=#{ENV['to']} rake sitemap:refresh"
  end

  desc 'Copy previous sitemap'
  remote_task :copy_old_sitemap => :require_deploy_env do
    run "if [ -e #{current_release}/public/sitemap_index.xml.gz ]; then cp #{current_release}/public/sitemap* #{latest_release}/public/; fi"
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
    :copy_old_sitemap,
    :cleanup
  ]
end
