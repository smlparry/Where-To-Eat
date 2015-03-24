class AdminController < ApplicationController
    before_action :authenticate_admin!
    def restaurants
        @restaurants = Restaurant.all().order('created_at DESC')
    end

    def delete_restaurant
        id = params[:id]
        Restaurant.find( id ).destroy
    end
end
