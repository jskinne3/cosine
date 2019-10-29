Rails.application.routes.draw do

  root controller: 'isbns', action: 'index'

  resources :syllabi
  resources :isbns
  resources :books

  # API routes
  get 'api/coassigned', controller: 'api', action: 'coassigned'
  get 'api/cips', controller: 'api', action: 'cips'
  get 'api/field', controller: 'api', action: 'field'

  # Custom views
  get '/reading_lists', controller: 'reading_lists', action: 'index'
  get 'reading_lists/coassigned', controller: 'reading_lists', action: 'coassigned'
  get 'reading_lists/cips', controller: 'reading_lists', action: 'cips'
  get 'reading_lists/field', controller: 'reading_lists', action: 'field'

  # https://github.com/plataformatec/devise/wiki/How-To:-Set-up-devise-as-a-single-user-system
  devise_for :users, controllers: { registrations: "registrations"}

end
