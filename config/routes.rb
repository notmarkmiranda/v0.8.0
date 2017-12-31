Rails.application.routes.draw do
  root 'pages#index'
  resources :users, only: [:show, :create]
  resources :clubs, except: [:destroy], param: :slug
  resources :leagues, except: [:destroy], param: :slug

  get   '/dashboard',    to: 'users#show', as: 'dashboard'
  get   '/sign-up',      to: 'users#new', as: 'sign_up'
  get   '/edit-profile', to: 'users#edit', as: 'edit_profile'
  patch '/edit-profile', to: 'users#update'

  get  '/sign-in',  to: 'sessions#new', as: 'sign_in'
  post '/sign-in',  to: 'sessions#create'
  get  '/sign-out', to: 'sessions#destroy'
end
