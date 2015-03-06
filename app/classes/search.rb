class Search
    def self.rank(price, long_lat = [-37.81361110,144.96305559])
        location = Location.new
        # Find within price range
        items = Item.where("price < ?", price)
        @results = Hash.new

        # Get distance from starting point
        items.each do |item|
            @results[location.distance(long_lat[0], long_lat[1], item.restaurant.latitude, item.restaurant.longitude)] = item.restaurant
        end

        # Sort by proximity
        # Only take the closest 100 restuarants (should be enough)
        @top_hundred = @results.sort.take(100)

        @final_results = Hash.new
        # Algorithm equation
        @top_hundred.each do |result|
            # So i dont get confuzzled
            restaurant = result[1]

            # Equation items
            rating = restaurant.rating
            items = restaurant.item.where("price < ?", price)
            proximity = result[0]*1000
            median = Parse.median_price(items)

            # Run the ranking calculation
            # See the Parse.rank method for further explaination
            ranking = Parse.rank(rating, items.count, proximity, median)
            # Can now sort most revelant by the key of the hash
            @final_results[ranking] = {restaurant: restaurant.name, items: items.count, distance: proximity, rating: rating, median: median}

        end
        # Sort in reverse order cause best fit is largest number
        result = @final_results.sort.reverse!

        # Add a option that says the default location was used
        if long_lat == [-37.81361110,144.96305559]
            result.unshift(message: "Results are being shown from Melbourne CBD")
        end

        result.take(50)

    end

end
