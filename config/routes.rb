Rails.application.routes.draw do

  root 'application#index'

  resources :users do
    resources :reminders
  end

  resources :tasks do
    resources :comments
    resources :notifications
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
