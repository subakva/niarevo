namespace :dev do
  desc "Create local domain aliases"
  task :create_host_aliases do
    domains = %w{
      niarevo.local
      www.niarevo.local
      m0.niarevo.local
      m1.niarevo.local
      m2.niarevo.local
      m3.niarevo.local
    }
    domains.each do |domain|
      `ghost add #{domain}`
    end
  end
end