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
        @results = Hash.new

        # Get distance from starting point
        items.each do |item|
            @results[location.distance(item.restaurant.latitude, item.restaurant.longitude)] = item.restaurant
        end

        # Sort by proximity
        @top_hundred = @results.sort.take(100)

        @final_results = Hash.new
        # Algorithm equation
        @top_hundred.each do |result|
            restaurant = result[1]

            # Equation items
            rating = restaurant.rating
            items = restaurant.item.where("price < ?", price)
            proximity = result[0]*1000
            median = Parse.median_price(items)

            # Run the equation
            # See the Parse.rank method for further explaination
            ranking = Parse.rank(rating, items.count, proximity, median)

            @final_results[ranking] = {restaurant: restaurant.name, items: items.count, distance: proximity, rating: rating, median: median}

        end
        result = @final_results.sort
        result.reverse!.take(20)
    end

end
