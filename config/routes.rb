Rails.application.routes.draw do
  devise_for :registrations
  root to: 'pages#home'

  resource :users, except: [ :new, :create, :index ] do
    resources :transactions, only: [ :index ]
  end

  resource :author, except: [ :new, :create ] do
    resources :books, except: [ :show, :index ]
  end

  resources :authors, only: [ :new, :create ]

  resources :books, only: [ :show ] do
    collection do
      get 'search', to: 'books#search'
    end

    resources :episodes, except: [:index] do
      resources :reviews, except: [:destroy, :show]
    end
end
  get 'dashboard', to: 'users#dashboard'
end

   
