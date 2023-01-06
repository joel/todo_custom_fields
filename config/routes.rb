Rails.application.routes.draw do

  resources :todos do
    resources :items
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "todos#index"
end
