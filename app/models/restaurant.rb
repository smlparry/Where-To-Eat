
class Restaurant < ActiveRecord::Base

    has_many :category
    has_many :item

    def fill_table
        parse = Parse.new
        # 75 pages in this one
        (1..75).each do |page|
            p page
            p "getting the list..."
            list = parse.get_list(page)
            p "done"
            @restaurants = []
            p "fetching restaurant details..."
            list.each do |url|
                @restaurants.push(parse.get_details(url))
            end
            p "done"
            p "inserting records..."
            self.insert(@restaurants)
            p "done"
            p "updating location..."
            self.update_location
            p "done"
        end
    end

    def details
        parse = Parse.new
        list = parse.get_list
        @restaurants = []
        list.each do |url|
            @restaurants.push(parse.get_details(url))
        end
        self.insert(@restaurants)
    end

    def insert(details)
        details.each do |restaurant_details|
            Restaurant.create(name: restaurant_details[:name], address: restaurant_details[:address], open_hours: restaurant_details[:open_hours], rating: restaurant_details[:rating], uri: restaurant_details[:uri])
        end
    end

    # Updates all the urban spoon ratings
    def update_ratings
        uris = Restaurant.pluck(:uri)
        parse = Parse.new
        @new_ratings = {}
        uris.each do |uri|
            @new_ratings[uri] = parse.get_ratings(uri)
        end
        @new_ratings.each do |rating|
            Restaurant.where({uri: rating[0]}).update_all({rating: rating[1][:rating]})
        end
    end

    # This class updates all the locations for the restuarants in the database
    def update_location
        # Get all empty records
        to_update = Restaurant.where(longitude: [false, nil, 1.0])
        # Update each
        to_update.each do |restaurant|
            restaurant.address
            long_lat = Location.long_lat(restaurant.address)
            Restaurant.where({id: restaurant.id}).update_all({longitude: long_lat[:longitude], latitude: long_lat[:latitude]})
        end
    end

    def self.insert_long_lat(restaurant_id, long_lat)
        Restaurant.where(id: restaurant_id).update_all({ longitude: long_lat[:longitude], latitude: long_lat[:latitude] })
    end

end
