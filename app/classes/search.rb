class Search
    def self.rank
        location = Location.new
        restaurants = Restaurant.all()
        @proximity = Hash.new
        restaurants.each do |restaurant|
            @proximity[location.distance(restaurant.latitude, restaurant.longitude)] = restaurant.name
        end

        @proximity.sort
    end
end
