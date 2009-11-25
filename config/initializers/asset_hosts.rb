ActionController::Base.asset_host = Proc.new do |source, request|
  if request.ssl?
    protocol = "https"
  else
    protocol = "http"
  end
  "#{protocol}://m#{rand(4)}.#{configatron.asset_hosts.asset_host_url}"
end
