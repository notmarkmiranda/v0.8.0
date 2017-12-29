Rails.application.routes.draw do
  resources :users, only: [:show, :create]
  get   '/dashboard', to: 'users#show', as: 'dashboard'
  get   '/sign-up', to: 'users#new', as: 'sign_up'
  get   '/edit-profile', to: 'users#edit', as: 'edit_profile'
  patch '/edit-profile', to: 'users#update'
end
