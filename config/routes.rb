Rails.application.routes.draw do
  devise_for :users, controllers: {
            registrations: "users/registrations",
            sessions: "users/sessions"
          }

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "home#index"
  # get "/users/sign_up" => "registrations#create"
  get "/dashboard" => 'home#show'
  get "/index" => 'home#index'
  get "/marketplace" => 'transactions#index'
  get "/transactions/show" => 'transactions#show', as: 'transaction_logs'
  get "/transactions/new" => 'transactions#new'
  get "/transactions" => 'transactions#show'
  get "/transactions/delete/:id" => 'transactions#destroy', as: 'delete_transaction'
  post "/transactions/create" =>  'transactions#create', as: 'create_transaction'
  patch "/transactions/update" => 'transactions#update'
  
  get "/stocks" => 'stocks#index', as: 'stocks'
  
  get "/admin" => 'users#index', as: 'admin'
  get "/user/confirm" => 'users#confirm', as: 'confirm_user'
  post "/user/create" => 'users#create', as: 'create_user'
  get "/user/new" => 'users#new', as: 'new_user'
  get "/user/:id" => 'users#show', as: 'show_user'
  patch "/user/:id" => 'users#update', as: 'update_user'
end
