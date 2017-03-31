Rails.application.routes.draw do

  root 'tasks#index'

  resources :users do
    post 'notifications/:id/view', to: 'notifications#view', as: :notification_view
    resources :reminders, only: [:new, :create, :destroy], shallow: true do
      post 'dismiss', to: 'reminders#dismiss', as: :dismiss
    end
  end

  resources :tasks do
    post 'request_assistance', to: 'tasks#request_assistance', as: :request_assistance
    post 'accept', to: 'tasks#accept', as: :accept
    post 'start', to: 'tasks#start', as: :start
    post 'mark_complete', to: 'tasks#mark_complete', as: :complete
    resources :comments, only: [:create, :destroy], shallow: true
  end

  resources :labels, only: [:index, :show, :new, :create]

  get '/signup', to: 'users#new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/auth/facebook/callback', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

end
