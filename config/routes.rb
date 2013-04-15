Niarevo::Application.routes.draw do
  root :to => 'dreams#index'

  resource :user_session, only: [:show, :new, :create, :destroy]
  resource :account, controller: "users", except: [:destroy]

  resources :users, :except => [:destroy]
  resources :password_resets, :except => [:destroy]
  resources :activations, :except => [:destroy]
  resources :invites, :except => [:destroy]

  match '/dreams/user/:id' => 'dreams#for_user', as: 'user_dreams'

  match '/dreams/tagged/:id' => 'dreams#for_tag', as: 'tag_dreams'
  match '/dreams/tagged/content/:id' => 'dreams#for_content_tag', as: 'content_tag_dreams'
  match '/dreams/tagged/context/:id' => 'dreams#for_context_tag', as: 'context_tag_dreams'

  match '/dreams/untagged' => 'dreams#untagged', as: 'untagged_dreams'
  match '/dreams/untagged_content' => 'dreams#untagged_content', as: 'untagged_content_dreams'
  match '/dreams/untagged_context' => 'dreams#untagged_context', as: 'untagged_context_dreams'

  match '/dreams/date/:year/:month/:day' => 'dreams#for_date',
    constraints: {:year => /\d{4}/, :month => /\d{1,2}/, :day => /\d{1,2}/},
    as: 'dreams_by_day'
  match '/dreams/date/:year/:month' => 'dreams#for_date',
    constraints: {:year => /\d{4}/, :month => /\d{1,2}/},
    as: 'dreams_by_month'
  match '/dreams/date/:year' => 'dreams#for_date',
    constraints: {:year => /\d{4}/},
    as: 'dreams_by_year'

  # The routes defined first take priority, so the resource should be last.
  resources :dreams do
    collection do
      get :preview
      post :preview
    end
  end

  resource :zeitgeist, only: [:show]

  match '/about' => 'static#about', as: 'about'
  match '/feeds' => 'static#feeds', as: 'feeds'
  match '/terms' => 'static#terms', as: 'terms'

  match '/facebook' => 'static#facebook', as: 'facebook'

  resource :facebook, controller: 'facebook', only: [] do
    member do
      post :deauthorization
      post :authorization
    end
  end
end
