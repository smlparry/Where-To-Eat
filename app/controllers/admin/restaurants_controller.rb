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
    @restaurant = Restaurant.find(params[:id])
  end

  def index
    @restaurants = Restaurant.all().order('updated_at DESC')
  end

  def new
  end

  def show
  end

  def destroy
    Restaurant.find(params[:id]).destroy
  end

  def update
    r = Restaurant.find(params[:id])
    r.name = params[:restaurant_name]
    r.address = params[:restaurant_address]
    r.contact_email = params[:contact_email]
    r.contact_name = params[:contact_name]
    r.save

  end
end