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
  match '/dreams/untagged' => 'dreams#untagged', as: 'untagged_dreams'

  match '/dreams/tagged/dream/:id' => 'dreams#for_dream_tag', as: 'dream_tag_dreams'
  match '/dreams/untagged_dream' => 'dreams#untagged_dream', as: 'untagged_dream_dreams'

  match '/dreams/tagged/dreamer/:id' => 'dreams#for_dreamer_tag', as: 'dreamer_tag_dreams'
  match '/dreams/untagged_dreamer' => 'dreams#untagged_dreamer', as: 'untagged_dreamer_dreams'

  # 301 for name change
  match '/dreams/tagged/content/:id', to: redirect('/dreams/tagged/dream/%{id}')
  match '/dreams/tagged/context/:id', to: redirect('/dreams/tagged/dreamer/%{id}')
  match '/dreams/untagged_content', to: redirect('/dreams/untagged_dream')
  match '/dreams/untagged_context', to: redirect('/dreams/untagged_dreamer')

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
