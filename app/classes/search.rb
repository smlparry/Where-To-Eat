class Search
    def self.rank(price, long_lat)

        location = Location.new
        # Find within price range
        items = Item.includes(:restaurant).where("price < ?", price)
        @results = Hash.new
        @restaurant_items = Hash.new

        # Get distance from starting point
        items.each do |item|
            if @restaurant_items[item.restaurant.id].blank?
                @restaurant_items[item.restaurant.id] = { items: [ item ] }
            else
                @restaurant_items[item.restaurant.id][:items] << item
            end
            @results[location.distance(long_lat[0], long_lat[1], item.restaurant.latitude, item.restaurant.longitude)] = { restaurant: item.restaurant }
        end

        @restaurant_items

        # # Sort by proximity
        # # Only take the closest 100 restuarants (should be enough)
        # @top_hundred = @results.sort.take(100)
        #
        # @top_hundred
        #
        # @final_results = Hash.new
        # # Algorithm equation
        # @top_hundred.each do |result|
        #     # So i dont get confuzzled
        #     restaurant = result[1]
        #
        #     # Equation items
        #     rating = restaurant.rating
        #     # Get the items from the orignal hash
        #     # items = items.where("price < ?", price)
        #     proximity = result[0]*1000
        #     median = Parse.median_price(items)
        #
        #     # Run the ranking calculation
        #     # See the Parse.rank method for further explaination
        #     ranking = Parse.rank(rating, items.count, proximity, median)
        #     # Can now sort most revelant by the key of the hash
        #     @final_results[ranking] = {restaurant: restaurant.name, items: items.count, distance: proximity, rating: rating, median: median}
        #
        # end
        # # Sort in reverse order cause best fit is largest number
        # result = @final_results.sort.reverse!
        #
        # # Add a option that says the default location was used
        # if long_lat == [-37.81361110,144.96305559]
        #     result.unshift(message: "Results are being shown from Melbourne CBD")
        # end
        #
        # result.take(50)

    end

end
