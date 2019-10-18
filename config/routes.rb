Rails.application.routes.draw do

  root controller: 'isbns', action: 'index'

  resources :syllabi
  resources :isbns
  resources :books

  get 'api/coassigned', controller: 'api', action: 'coassigned'

  get '/reading_lists', controller: 'reading_lists', action: 'index'

  # https://github.com/plataformatec/devise/wiki/How-To:-Set-up-devise-as-a-single-user-system
  devise_for :users, controllers: { registrations: "registrations"}

end
