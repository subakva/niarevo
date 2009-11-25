namespace :db do
  desc "Configures the database.yml for the current server"
  task :configure do
    hostname = `hostname`.strip
    FileUtils.cp(
      File.join(RAILS_ROOT, 'config', "database.#{hostname}.yml"),
      File.join(RAILS_ROOT, 'config', 'database.yml')
    )
  end
end
