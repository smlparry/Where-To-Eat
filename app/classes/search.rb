class Search
    def self.closest
        location = Location.new
        restaurants = Restaurant.all()
        @proximity = Hash.new
        restaurants.each do |restaurant|
            @proximity[location.distance(restaurant.latitude, restaurant.longitude)] = restaurant.name
        end
        @proximity.sort
    end

    def self.rank(price, location = [144.9556878,-37.8053885])
        location = Location.new
        # Find within price range
        items = Item.where("price < ?", price)
        @rank = Hash.new
        # Sort by proximity
        items.each do |item|
            @rank[location.distance(item.restaurant.latitude, item.restaurant.longitude)] = item.restaurant.name
        end
        @rank.sort

        # Algorithm equation
        # (Rating*No.Items)/(Proximity/MedianPrice)
    end

end
