Rails.application.routes.draw do
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
end
