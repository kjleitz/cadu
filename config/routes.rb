Rails.application.routes.draw do

  root 'application#index'

  resources :users do
    resources :reminders
    resources :notifications
  end

  resources :tasks do
    resources :comments
  end

  resources :labels

  post '/task/:id/request_assistance', to: 'tasks#request_assistance', as: :request_assistance

end
