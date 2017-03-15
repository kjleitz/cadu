Rails.application.routes.draw do

  root 'application#index'

  resources :users do
    resources :reminders
    resources :notifications
  end

  resources :tasks do
    resources :comments
  end

end
