Rails.application.routes.draw do
  resources :meanbodies
  resources :meanings
  resources :phrases
  resources :users
  resources :prepadvs
  resources :verbs
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
