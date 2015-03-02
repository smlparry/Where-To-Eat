# A class for patching existing records in the database
class Patch
    def self.get_failed_log
        restaurants = Restaurant.where(longitude: 1).all()
        location = Location.new
        restaurants.each do |restaurant|
            long_lat = location.long_lat(location.get_location, restaurant.address)
            Restaurant.insert_long_lat(restaurant.id, long_lat)
        end
    end
end
