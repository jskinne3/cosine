Rails.application.routes.draw do

  root controller: 'isbns', action: 'index'

  resources :syllabi
  resources :isbns
  resources :books

  get 'api/coassigned', controller: 'api', action: 'coassigned'
  get 'api/cips', controller: 'api', action: 'cips'

  get '/reading_lists', controller: 'reading_lists', action: 'index'
  get 'reading_lists/coassigned', controller: 'reading_lists', action: 'coassigned'

  # https://github.com/plataformatec/devise/wiki/How-To:-Set-up-devise-as-a-single-user-system
  devise_for :users, controllers: { registrations: "registrations"}

end
