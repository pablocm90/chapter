Rails.application.routes.draw do
  root to: 'pages#home'
  resources :books
  get 'books/search', to: 'books#search'
end
