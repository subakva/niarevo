ActionController::Routing::Routes.draw do |map|
  map.resource :user_session
  map.resource :account, :controller => "users"
  map.resources :users
  map.resources :password_resets

  map.resources :dreams
  map.user_dreams '/dreams/user/:id', :controller => :dreams, :action => :for_user
  map.tag_dreams '/dreams/tagged/:id', :controller => :dreams, :action => :for_tag

  map.root :controller => "dreams", :action => "index"
end
