Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :images, only: %i[new create show index destroy]
  root 'images#index'
  # application resource
  resources :application, only: %i[show]
  # feedback resource
  resources :feedbacks, only: [:new]
  # feedback api resource
  namespace :api do
    resource :feedbacks, only: [:create]
  end
end
