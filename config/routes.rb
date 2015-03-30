Rails.application.routes.draw do
  # Root route
  root 'pages#index'
  
  # Devise
  devise_for :admins

  # Restful routes
  namespace :admin do 
    resources :restaurants
  end

  resources :charges
  resources :menu

  # Random routes
  get 'page/index'
  get 'page/request'
  get '/request' => 'pages#request_access'
  post '/mailing_list' => 'pages#mailing_list'
  get 'add-restaurant' => 'pages#add_restaurant'
  get 'api/rank'
  # get 'admin/restaurants'
  # get 'admin/restaurants/delete/:id' => 'admin#delete_restaurant'
  # get 'admin/restaurants/items/:id' => 'admin#restaurant_items'
  get 'admin/beta'
  get 'insert_menu/category'
  get 'insert_menu/restaurant'
  get 'insert_menu/items'
  post 'insert_menu/category'
  post 'insert_menu/items'
  post 'insert_menu/restaurant'

  # get 'restaurants/add'
  # post 'restaurants/add'


end
