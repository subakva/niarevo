namespace :vars do
  task :load_dot_env do
    env_file_name = File.expand_path("../../../.env", __FILE__)

    if File.exists?(env_file_name)
      File.read(env_file_name).split("\n").each do |line|
        match = line.match(/export (\w+)=(.*)/)
        if match
          key, value = match[1..2]
          ENV[key] = value
        end
      end
    end
  end
end

task vars: 'vars:load_dot_env'
