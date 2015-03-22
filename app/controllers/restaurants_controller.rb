class RestaurantsController < ApplicationController
  def add
      if ! params[:restaurant_name].blank?
          @restaurant = Restaurant.create(name: params[:restaurant_name], address: params[:restaurant_address], contact_email: params[:contact_email], contact_name: params[:contact_name])

          render 'restaurants/pay'
      end
  end
end
