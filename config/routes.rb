# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'dreams#index'

  resource :user_session, only: [:show, :new, :create, :destroy]
  resource :account, controller: "users", except: [:destroy]

  resources :users, except: [:destroy]
  resources :password_resets, except: [:destroy]
  resources :activations, except: [:destroy]
  resources :invites, except: [:destroy]

  get '/dreams/user/:id', to: 'dreams#for_user', as: 'user_dreams'

  get '/dreams/tagged/:id', to: 'dreams#for_tag', as: 'tag_dreams'
  get '/dreams/untagged', to: 'dreams#untagged', as: 'untagged_dreams'

  get '/dreams/tagged/dream/:id', to: 'dreams#for_dream_tag', as: 'dream_tag_dreams'
  get '/dreams/untagged_dream', to: 'dreams#untagged_dream', as: 'untagged_dream_dreams'

  get '/dreams/tagged/dreamer/:id', to: 'dreams#for_dreamer_tag', as: 'dreamer_tag_dreams'
  get '/dreams/untagged_dreamer', to: 'dreams#untagged_dreamer', as: 'untagged_dreamer_dreams'

  # 301 for name change
  get '/dreams/tagged/content/:tag', to: redirect('/dreams/tagged/dream/%{tag}')
  get '/dreams/tagged/context/:tag', to: redirect('/dreams/tagged/dreamer/%{tag}')
  get '/dreams/untagged_content', to: redirect('/dreams/untagged_dream')
  get '/dreams/untagged_context', to: redirect('/dreams/untagged_dreamer')

  get '/dreams/date/:year/:month/:day',
      to: 'dreams#for_date',
      constraints: {
        year: /\d{4}/,
        month: /\d{1,2}/,
        day: /\d{1,2}/
      },
      as: 'dreams_by_day'
  get '/dreams/date/:year/:month',
      to: 'dreams#for_date',
      constraints: {
        year: /\d{4}/,
        month: /\d{1,2}/
      },
      as: 'dreams_by_month'
  get '/dreams/date/:year',
      to: 'dreams#for_date',
      constraints: {
        year: /\d{4}/
      },
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
end
