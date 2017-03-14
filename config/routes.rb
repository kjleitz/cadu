Rails.application.routes.draw do

  root 'application#index'

  resources :users do
    resources :reminders
  end

  resources :tasks do
    resources :comments
    resources :notifications
  end

end
