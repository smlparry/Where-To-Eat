class Search
    def self.rank(price, long_lat)

        location = Location.new
        # Find within price range
        items = Item.includes(:restaurant).where("price < ?", price)
        @results = Hash.new
        @restaurant_items = Hash.new

        # Get distance from starting point
        items.each do |item|
            # If the restaurant hasnt yet been added to the @restaurant_items hash
            if @restaurant_items[item.restaurant.id].blank?
                # Add an array of items to the hash
                @restaurant_items[item.restaurant.id] = [ item ]
            else
                # Append the new item to the existing array of items
                @restaurant_items[item.restaurant.id] << item
            end
            @results[location.distance(long_lat[0], long_lat[1], item.restaurant.latitude, item.restaurant.longitude)] = { restaurant: item.restaurant, items: @restaurant_items[item.restaurant.id] }
        end

        # Sort by proximity
        # Only take the closest 100 restuarants (should be enough)
        @top_hundred = @results.sort.take(100)

        @final_results = Hash.new
        # Algorithm equation
        @top_hundred.each do |result|
            # So i dont get confuzzled
            restaurant = result[1][:restaurant]

            # Equation items
            rating = restaurant.rating
            # Get the items from the orignal hash
            items = result[1][:items]
            proximity = result[0]*1000
            median = Parse.median_price(items)

            # Run the ranking calculation
            # See the Parse.rank method for further explaination
            ranking = Parse.rank(rating, items.count, proximity, median)
            # Can now sort most revelant by the key of the hash
            @final_results[ranking] = {restaurant: restaurant.name, items: items, distance: proximity, rating: rating, median: median}

        end
        # Sort in reverse order cause best fit is largest number
        result = @final_results.sort.reverse!

        @test_results = []

        result.each do |result|
            result.shift
        end

        # Add a option that says the default location was used
        if long_lat == [-37.81361110,144.96305559]
            result.unshift(message: "Results are being shown from Melbourne CBD")
        end

        result.take(50)

    end

end
