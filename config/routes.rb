Rails.application.routes.draw do

  root 'tasks#index'

  resources :users do
    resources :reminders, shallow: true
    resources :notifications
  end

  resources :tasks do
    resources :comments, shallow: true
  end

  resources :labels

  post '/task/:id/request_assistance', to: 'tasks#request_assistance', as: :request_assistance
  post '/task/:id/mark_complete', to: 'tasks#mark_complete', as: :complete_task
  post '/reminders/:id/dismiss', to: 'reminders#dismiss', as: :dismiss_reminder

  get '/signup', to: 'users#new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

end
