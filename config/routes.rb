Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :works

  #custom route for homepage:
  root :to => 'works#homepage'

  resources :users, only: [:index, :show]

  # get '/users/login', to: 'users#login', as: :login_user
  # post ''

end
