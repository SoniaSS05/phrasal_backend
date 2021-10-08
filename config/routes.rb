Rails.application.routes.draw do
  resources :meanbodies
  resources :meanings
  resources :phrases
  resources :users
  resources :prepadvs
  resources :verbs
  
  get '/verbs/:id/prepadvs', to: 'verbs#phrasalverb'
  post '/users/:id/:phrasal_id', to: 'users#add_phrasal'
  get 'users/:id/:phrasal_id', to: 'users#show_users_phrasal'
  #post 'users/:id/:verb_id', to: 'users#add_verb'


  get '/phrasals/', to: 'phrasals#index'

end

