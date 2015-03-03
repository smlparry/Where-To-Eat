
class Restaurant < ActiveRecord::Base

    has_many :category
    has_many :item

    def fill_table
        parse = Parse.new
        (10..50).each do |page|
            p "getting the list"
            list = parse.get_list(page)
            @restaurants = []
            p "fetching restaurant details"
            list.each do |url|
                @restaurants.push(parse.get_details(url))
            end
            self.insert(@restaurants)
            p "updating location"
            self.update_location
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
    def self.update_location
        # Get all empty records
        to_update = Restaurant.where(longitude: [false, nil])
        # Update each
        to_update.each do |restaurant|
            long_lat = Location.get_location(restaurant.address)
            Restaurant.where({id: restaurant.id}).update_all({longitude: long_lat[:longitude], latitude: long_lat[:latitude]})
        end
    end

    def self.insert_long_lat(restaurant_id, long_lat)
        Restaurant.where(id: restaurant_id).update_all({ longitude: long_lat[:longitude], latitude: long_lat[:latitude] })
    end

end
