# A class for patching existing records in the database
class Patch
    # This finds all the restaurants in the database in which the google api didnt pick
    # up the longitude and latitude. Mostly due to hitting the api limit but some have
    # faulty addresses from the urban spoon scraper
    def self.get_failed_log
        restaurants = Restaurant.where(longitude: [false, nil, 1.0]).all()
        restaurants.each do |restaurant|
            long_lat = Location.long_lat(restaurant.address)
            Restaurant.insert_long_lat(restaurant.id, long_lat)
        end
    end

    # Updates relational ids of items and categorys when you fuck up and reset all
    # restaurants and hence relations :/
    def self.relational_seeder
        i = Item.all()
        i.each do |i|
            Item.where(id: i.id).update_all(restaurant_id: rand(213..364))
        end
        c = Category.all()
        c.each do |c|
            Category.where(id: c.id).update_all(restaurant_id: rand(213..364))
        end
    end

    # find the closest x
    def self.closest(amount = 100)
            location = Location.new
            restaurants = Restaurant.all()
            @proximity = Hash.new
            restaurants.each do |restaurant|
                @proximity[location.distance(-37.81361110, 144.96305559, restaurant.latitude, restaurant.longitude)] = restaurant.name
            end
            @proximity.count
        end
end
