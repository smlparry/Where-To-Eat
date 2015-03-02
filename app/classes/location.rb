require 'server-side-google-maps'

class Location
    def self.distance
        route = ServerSideGoogleMaps::Route.new(['8 Rankins Lane Melbourne', '4 Rankins Lane Melbourne'])
        p route.distance*0.001
    end
end
