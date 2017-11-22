  Rails.application.routes.draw do
  root to: 'pages#home'
  get "about", to: 'pages#about'

  devise_for :registrations, :controllers => { registrations: "registrations"}

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

    member do
      get "download", to: 'books#download_book', as: :download
      get "download_owned", to: 'books#download_owned_book', as: :download_owned_book
    end

    resources :episodes, except: [:index] do
      resources :transactions, only: [ :new, :create]
      member do
        get "download", to: 'episodes#download_episode', as: :download
      end
    end

    resources :reviews, except: [:destroy, :show]
    end

  get 'dashboard', to: 'users#dashboard'
  get 'author_dashboard', to: 'authors#dashboard'

  resources :topups, only: [:index]

  resources :orders, only: [:show, :create] do
    resources :payments, only: [:new, :create]
  end

end


