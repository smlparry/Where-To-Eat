class Admin::RestaurantsController < ApplicationController
  
  before_action :authenticate_admin!

  def create
    if ! params[:restaurant_name].blank?
      @restaurant = Restaurant.create(name: params[:restaurant_name],
                                      address: params[:restaurant_address],
                                      contact_email: params[:contact_email],
                                      contact_name: params[:contact_name],
                                      subscription_amount: params[:amount])
     @charge_amount = @restaurant.subscription_amount * 100
     render 'charges/new'
    end
  end

  def edit
  end

  def index
    @restaurants = Restaurant.all()
  end

  def new
  end

  def show
  end

  def destroy
  end
end