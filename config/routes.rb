Rails.application.routes.draw do
  resources :meanbodies
  resources :meanings
  resources :phrases
  resources :users
  resources :prepadvs
  resources :verbs
  
  get '/verbs/:id/prepadvs', to: 'verbs#phrasalverb'

get '/phrasals/', to: 'phrasals#index'

end

