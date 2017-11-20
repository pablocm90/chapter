Rails.application.routes.draw do
  devise_for :registrations
  root to: 'pages#home'

  resource :users, except: [ :new, :create, :index ] do
    resources :transactions, only: [ :index ]
  end
  resources :authors, only: [ :new, :create ]

  resources :authors, except: [ :new, :create ] do
    resources :books, except: [ :show, :index ]
  end


  resources :books, only: [ :show ] do
    collection do
      get 'search', to: 'books#search'
    end

    resources :episodes, except: [:index] do
      resources :transactions, only: [ :new, :create]
      member do
        get "download", to: 'episodes#download', as: :download
      end
    end

    resources :reviews, except: [:destroy, :show]

end
  get 'dashboard', to: 'users#dashboard'
  get 'author_dashboard', to: 'authors#dashboard'
end


