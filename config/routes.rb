Rails.application.routes.draw do

  root controller: 'isbns', action: 'index'

  resources :syllabi
  resources :isbns
  resources :books

  get 'api/isbns', controller: 'api', action: 'isbns'

end
