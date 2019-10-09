Rails.application.routes.draw do

  root controller: 'isbns', action: 'index'

  resources :syllabi
  resources :isbns
  resources :books
end
