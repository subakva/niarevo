namespace :dev do
  desc "Create local domain aliases"
  task :create_host_aliases do
    domains = %w{
      dreamtagger.local
      www.dreamtagger.local
      m0.dreamtagger.local
      m1.dreamtagger.local
      m2.dreamtagger.local
      m3.dreamtagger.local
    }
    domains.each do |domain|
      `ghost add #{domain}`
    end
  end
end