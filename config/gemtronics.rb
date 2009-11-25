group(:default) do |g|
  g.add('gemtronics', :version => '>=0.7.2')
  g.add('rails', :version => '2.3.4')
  g.add('is_taggable', :version => '0.1.0')
  g.add('authlogic', :version => '2.1.2')
  g.add('searchlogic', :version => '2.3.6')
  g.add('will_paginate', :version => '2.3.11')
  g.add('gravtastic', :version => '2.1.3')
  g.add('rdiscount', :version =>'1.5.5')
  g.add('matthuhiggins-foreigner', :version => '0.3.1', :require => 'foreigner')
  g.add('configatron', :version => '2.5.1')
  g.add('recaptcha', :version => '0.2.3', :require => 'recaptcha/rails')
end

group(:production, :dependencies => :default) do |g|
  g.add('newrelic_rpm', :version => '2.9.8')
end

group(:development, :dependencies => :default) do |g|
  g.add('newrelic_rpm', :version => '2.9.8')
end

group(:test, :dependencies => :development, :load => false) do |g|
  g.add('rspec',  :version => '1.2.9', :require => 'spec/autorun')
  g.add('rspec-rails', :version => '1.2.9', :require => 'spec/rails')
  g.add('rcov', :version => '0.9.6')
  g.add('thoughtbot-factory_girl', :version => '1.2.2', :require => 'factory_girl')
  g.add('remarkable_rails', :version => '3.1.11')
  g.add('jscruggs-metric_fu', :version => '1.1.5')
  g.add('bmabey-email_spec', :version => '0.3.4', :require => 'email_spec')
  g.add('fakeweb', :version => '1.2.7')
end

group(:cucumber, :dependencies => :test, :load => false) do |g|
  g.add('cucumber', :version => '0.4.3')
  g.add('webrat', :version => '0.5.3')
  g.add('nokogiri', :version => '1.4.0')
end
