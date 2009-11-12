group(:default) do |g|
  g.add('gemtronics', :version => '0.7.2')
  g.add('rails', :version => '2.3.4')
  g.add('is_taggable', :version => '0.1.0')
  g.add('authlogic', :version => '2.1.2')
  g.add('searchlogic', :version => '2.3.6')
end

group(:production, :dependencies => :default) do |g|
  
end

group(:development, :dependencies => :default) do |g|
  
end

group(:test, :dependencies => :development, :load => false) do |g|
  g.add('rspec',  :version => '1.2.9', :require => 'spec/autorun')
  g.add('rspec-rails', :version => '1.2.9', :require => 'spec/rails')
  g.add('rcov', :version => '0.9.6')
  g.add('thoughtbot-factory_girl', :version => '1.2.2', :require => 'factory_girl')
  g.add('remarkable_rails', :version => '3.1.11')
  g.add('jscruggs-metric_fu', :version => '1.1.5')
end

group(:cucumber, :dependencies => :test) do |g|
  g.add('cucumber', :version => '0.4.3')
  g.add('webrat', :version => '0.5.3')
  g.add('nokogiri', :version => '1.3.3')
end
