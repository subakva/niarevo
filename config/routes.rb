Rails.application.routes.draw do
  root :to => 'dreams#index'

  resource :user_session, only: [:show, :new, :create, :destroy]
  resource :account, controller: "users", except: [:destroy]

  resources :users, :except => [:destroy]
  resources :password_resets, :except => [:destroy]
  resources :activations, :except => [:destroy]
  resources :invites, :except => [:destroy]

  get '/dreams/user/:id' => 'dreams#for_user', as: 'user_dreams'

  get '/dreams/tagged/:id' => 'dreams#for_tag', as: 'tag_dreams'
  get '/dreams/untagged' => 'dreams#untagged', as: 'untagged_dreams'

  get '/dreams/tagged/dream/:id' => 'dreams#for_dream_tag', as: 'dream_tag_dreams'
  get '/dreams/untagged_dream' => 'dreams#untagged_dream', as: 'untagged_dream_dreams'

  get '/dreams/tagged/dreamer/:id' => 'dreams#for_dreamer_tag', as: 'dreamer_tag_dreams'
  get '/dreams/untagged_dreamer' => 'dreams#untagged_dreamer', as: 'untagged_dreamer_dreams'

  # 301 for name change
  get '/dreams/tagged/content/:id', to: redirect('/dreams/tagged/dream/%{id}')
  get '/dreams/tagged/context/:id', to: redirect('/dreams/tagged/dreamer/%{id}')
  get '/dreams/untagged_content', to: redirect('/dreams/untagged_dream')
  get '/dreams/untagged_context', to: redirect('/dreams/untagged_dreamer')

  get '/dreams/date/:year/:month/:day' => 'dreams#for_date',
    constraints: {:year => /\d{4}/, :month => /\d{1,2}/, :day => /\d{1,2}/},
    as: 'dreams_by_day'
  get '/dreams/date/:year/:month' => 'dreams#for_date',
    constraints: {:year => /\d{4}/, :month => /\d{1,2}/},
    as: 'dreams_by_month'
  get '/dreams/date/:year' => 'dreams#for_date',
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

  get '/about' => 'static#about', as: 'about'
  get '/feeds' => 'static#feeds', as: 'feeds'
  get '/terms' => 'static#terms', as: 'terms'

  get '/facebook' => 'static#facebook', as: 'facebook'

  resource :facebook, controller: 'facebook', only: [] do
    member do
      post :deauthorization
      post :authorization
    end
  end
end
