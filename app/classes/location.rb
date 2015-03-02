require 'server-side-google-maps'
require 'geo-distance'

class Location
    def get_location
        [-37.7985396,144.9597427]
    end

    def get_route(current_location, address)
        ServerSideGoogleMaps::Route.new([current_location, address])
    end

    def distance(current_location, address)
        begin
            route = self.get_route(current_location, address)
            distance = route.distance*0.001
        rescue
            distance = 'n/a'
        end
        distance
    end

    def long_lat(current_location, address)
        begin
            route = self.get_route(current_location, address)
            long_lat = Hash.new
            long_lat[:longitude] = route.destination_point.longitude
            long_lat[:latitude] = route.destination_point.latitude
        rescue
            long_lat = Hash.new
            long_lat[:longitude] = 1
            long_lat[:latitude] = 1
        end
        long_lat
    end

    def get_log
        restaurants = Restaurant.all()
        restaurants.each do |restaurant|
            long_lat = self.long_lat(self.get_location, restaurant.address)
            Restaurant.insert_long_lat(long_lat)
        end
    end

    def distance(longitude, latitude)
        long_lat = self.get_location
        lon1 = long_lat[0]
        lat1 = long_lat[1]

        lon2 = longitude
        lat2 = latitude

        dist = GeoDistance.distance( lat1, lon1, lat2, lon2 )
        dist.meters.distance*0.001
    end
end
