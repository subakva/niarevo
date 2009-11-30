ActionController::Routing::Routes.draw do |map|
  map.resource :user_session
  map.resource :account, :controller => "users"
  map.resources :users
  map.resources :password_resets
  map.resources :activations
  map.resources :invites

  map.user_dreams '/dreams/user/:id', :controller => :dreams, :action => :for_user

  map.tag_dreams '/dreams/tagged/:id', :controller => :dreams, :action => :for_tag
  map.content_tag_dreams '/dreams/tagged/content/:id', :controller => :dreams, :action => :for_content_tag
  map.context_tag_dreams '/dreams/tagged/context/:id', :controller => :dreams, :action => :for_context_tag

  map.untagged_dreams '/dreams/untagged', :controller => :dreams, :action => :untagged
  map.untagged_content_dreams '/dreams/untagged/content', :controller => :dreams, :action => :untagged_content
  map.untagged_context_dreams '/dreams/untagged/context', :controller => :dreams, :action => :untagged_context

  map.dreams_by_day '/dreams/date/:year/:month/:day', :controller => :dreams, :action => :for_date,
    :year => /\d{4}/, :month => /\d{1,2}/, :day => /\d{1,2}/
  map.dreams_by_month '/dreams/date/:year/:month', :controller => :dreams, :action=> :for_date,
    :year => /\d{4}/, :month => /\d{1,2}/
  map.dreams_by_year '/dreams/date/:year', :controller => :dreams, :action => :for_date,
    :year => /\d{4}/

  map.resources :dreams, :collection => {:preview => [:get, :post]}

  map.resource :zeitgeist, :only => :show

  map.about '/about', :controller => 'static', :action => 'about'
  map.feeds '/feeds', :controller => 'static', :action => 'feeds'
  map.terms '/terms', :controller => 'static', :action => 'terms'
  map.facebook '/facebook', :controller => 'static', :action => 'facebook'
  map.root :controller => "dreams", :action => "index"
end
