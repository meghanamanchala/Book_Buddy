Rails.application.routes.draw do
  resources :reviews
  # Root route goes to login page (sessions#new)
  root 'sessions#new'

  # User registration routes
  resources :users, only: [:new, :create, :show, :edit, :update,:destroy,:index]

  # Signup path alias for convenience
  get '/signup', to: 'users#new', as: 'signup'

  # Login routes
  get '/login', to: 'sessions#new', as: 'login'
  post '/sessions', to: 'sessions#create', as: 'sessions'

  # Logout route
  delete '/logout', to: 'sessions#destroy', as: 'logout'

  # User dashboard (custom route)
  get '/dashboard', to: 'users#dashboard', as: 'dashboard'
  post '/toggle_theme', to: 'application#toggle_theme', as: 'toggle_theme'

  # Book CRUD routes
  resources :books do
    member do
      patch :restore
    end
    resources :reviews, only: [:create]
  end

end
