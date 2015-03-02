class Search
    def self.rank
        location = Location.new
        restaurants = Restaurant.all()
        @distance_hash = Hash.new
        restaurants.each do |restaurant|
            @distance_hash[location.distance(location.get_location, restaurant.address)] = restaurant.name
        end
        @distance_hash
    end
end
