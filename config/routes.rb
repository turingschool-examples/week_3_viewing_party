Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'welcome#index'
    resources :users, only: [:index, :show, :new, :create]
    get '/login', to: 'users#login_form'
    post '/login', to: 'users#login_user'
  get '/register', to: 'users#new'
  post '/users', to: 'users#create'
  get '/users/:id/movies', to: 'movies#index', as: 'movies'
  get '/users/:user_id/movies/:id', to: 'movies#show', as: 'movie'

  # resources :users, only: :show
end
