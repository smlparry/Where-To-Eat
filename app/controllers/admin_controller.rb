class AdminController < ApplicationController
    before_action :authenticate_admin!
    def restaurants
        
    end
end
