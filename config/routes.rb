Rails.application.routes.draw do

  resources :users

  resources :tasks do
    resources :comments
  end

  resources :notifications

  resources :reminders
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
