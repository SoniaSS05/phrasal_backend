Rails.application.routes.draw do
  resources :meanbodies
  resources :meanings
  resources :phrases
  resources :users
  resources :prepadvs
  resources :verbs
  
  get '/verbs/:id/', to: 'verbs#phrasalverb'

post '/users/:id/add_phrasal', to: 'users#add_phrasal'


  patch '/users/1/:id', to: 'users#upd_user_phrasal'

get '/phrasals/', to: 'phrasals#index'

end

