Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :images, only: %i[new create show index destroy]
  root 'images#index'
  resources :application, only: %i[show]
end
