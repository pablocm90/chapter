Rails.application.routes.draw do
  root to: 'pages#home'
  resources :books do
    resources :episodes
    collection do
      get 'search', to: 'books#search'
    end
  end
end
