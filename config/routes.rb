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
  end
  get '/books/:book_id/episodes/:id/buy' => 'episodes#buy', as: :buy_episodes

  resources :users, except: [ :index ]
end
