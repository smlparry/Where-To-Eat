Rails.application.routes.draw do

    #### TOOOOO DOOOOOOO ######
    ## MAKE ROUTES RESTFUL ##
    # Not currently done cause im lazy and in a rush
  devise_for :admins

  root 'pages#index'

  get 'page/index'

  get 'page/request'

  get 'restaurants/add'
  post 'restaurants/add'

  get '/request' => 'pages#request_access'
  post '/mailing_list' => 'pages#mailing_list'

  resources :charges


  get 'add-restaurant' => 'pages#add_restaurant'

  get 'api/rank'

  get 'admin/restaurants'
  get 'admin/restaurants/delete/:id' => 'admin#delete_restaurant'
  get 'admin/restaurants/items/:id' => 'admin#restaurant_items'
  get 'admin/beta'

  get 'insert_menu/category'

  get 'insert_menu/restaurant'

  get 'insert_menu/items'

  post 'insert_menu/category'

  post 'insert_menu/items'

  post 'insert_menu/restaurant'
end
