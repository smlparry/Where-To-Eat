class Restaurant < ActiveRecord::Base

    def fill_table
        parse = Parse.new
        (3..10).each do |page|
            list = parse.get_list(page)
            @restaurants = []
            list.each do |url|
                @restaurants.push(parse.get_details(url))
            end
            self.insert(@restaurants)
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
end
