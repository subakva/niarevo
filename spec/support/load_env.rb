if File.exists?('.env')
  File.read('.env').split("\n").each do |line|
    match = line.match(/export (\w+)=(.*)/)
    if match
      key, value = match[1..2]
      ENV[key] = value
    end
  end
end
