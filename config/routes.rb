Rails.application.routes.draw do
  root to: 'pages#home'
  resources :books do
    resources :chapters
    collection do
      get 'search', to: 'books#search'
    end
  end
end
