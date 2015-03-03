# A class for patching existing records in the database
class Patch
    # This finds all the restaurants in the database in which the google api didnt pick
    # up the longitude and latitude. Mostly due to hitting the api limit but some have
    # faulty addresses from the urban spoon scraper
    def self.get_failed_log
        restaurants = Restaurant.where(longitude: 1).all()
        location = Location.new
        restaurants.each do |restaurant|
            long_lat = location.long_lat(location.get_location, restaurant.address)
            Restaurant.insert_long_lat(restaurant.id, long_lat)
        end
    end
end
