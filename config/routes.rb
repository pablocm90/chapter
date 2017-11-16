Rails.application.routes.draw do
  devise_for :registrations
  root to: 'pages#home'
  resources :books do
    resources :episodes
    collection do
      get 'search', to: 'books#search'
    end
    member do
    get "buy", to: "books#buy"
    end
    resources :reviews, except: [:destroy, :show]
  end
  get '/books/:book_id/episodes/:id/buy' => 'episodes#buy', as: :buy_episodes

  resources :users, except: [ :index ] do
    resources :transactions, only: [ :index ]
  end
  get 'dashboard', to: 'users#dashboard'
end
