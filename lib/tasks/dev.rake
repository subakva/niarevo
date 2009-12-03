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

  desc "Generate Test Data"
  task :generate_test_data => :environment do
    include ActionView::Helpers::TextHelper

    num_users = 10
    users = []
    num_users.times do
      name = "tester#{rand(10000)}"
      users << User.create!(
        :username => name,
        :email => "#{name}@example.com",
        :password => "password",
        :password_confirmation => "password"
      )
    end

    lorem = 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.'
    tags = %w{Lorem ipsum dolor sit amet consectetur adipisicing elit sed do eiusmod tempor incididunt ut labore}
    30.times do
      random_user = (rand(2) == 1) ? nil : users[rand(num_users - 1)]
      description = truncate(lorem, :length => rand(400))
      content_tag_list = tags.shuffle[0, rand(tags.size - 1)]
      context_tag_list = tags.shuffle[0, rand(tags.size - 1)]
      Dream.create!(
        :user => random_user,
        :description => description,
        :content_tag_list => content_tag_list,
        :context_tag_list => context_tag_list
      )
    end
    
  end
end