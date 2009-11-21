ActionController::Routing::Routes.draw do |map|
  map.resource :user_session
  map.resource :account, :controller => "users"
  map.resources :users
  map.resources :password_resets

  map.resources :dreams
  map.user_dreams '/dreams/user/:id', :controller => :dreams, :action => :for_user
  map.tag_dreams '/dreams/tagged/:id', :controller => :dreams, :action => :for_tag
  map.dreams_by_day '/dreams/date/:year/:month/:day', :controller => :dreams, :action => :for_date,
    :year => /\d{4}/, :month => /\d{1,2}/, :day => /\d{1,2}/
  map.dreams_by_month '/dreams/date/:year/:month', :controller => :dreams, :action=> :for_date,
    :year => /\d{4}/, :month => /\d{1,2}/
  map.dreams_by_year '/dreams/date/:year', :controller => :dreams, :action => :for_date,
    :year => /\d{4}/

  map.about '/about', :controller => 'static', :action => 'about'
  map.feeds '/feeds', :controller => 'static', :action => 'feeds'
  map.terms '/terms', :controller => 'static', :action => 'terms'
  map.root :controller => "dreams", :action => "index"
end
