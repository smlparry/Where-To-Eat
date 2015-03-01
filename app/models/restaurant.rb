class Restaurant < ActiveRecord::Base

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
            Restaurant.create(name: restaurant_details[:name], address: restaurant_details[:address], open_hours: restaurant_details[:open_hours])
        end
    end
end
