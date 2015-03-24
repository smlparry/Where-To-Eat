class AdminController < ApplicationController
    before_action :authenticate_admin!
    def restaurants
        @restaurants = Restaurant.all().order('created_at DESC')
    end
end
