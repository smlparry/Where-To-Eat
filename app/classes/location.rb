require 'server-side-google-maps'

class Location
    def self.distance
        (0..10).each do |i|
            route = ServerSideGoogleMaps::Route.new([[ 45.4119000, -75.6984600 ], [45.4119000, -75.6984600 ]])
            p route.distance*0.001
        end
    end
end
