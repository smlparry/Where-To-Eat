require 'nokogiri'
require 'open-uri'

# This class parses the html from the input url
class Parse

    # Finds the median price for set of data
    # Primarily used for the search algorithm to find the median item price
    def self.median_price(array)
        price_hash = Hash.new
        array.each do |item|
            price_hash[item.price] = item
        end

        sorted = price_hash.sort
        len = sorted.length
        return (sorted[(len - 1) / 2][0] + sorted[len/2][0]) / 2.0
    end

    # The ranking algorithm
    # Mainly referenced in the search class
    # Takes 4 parameters
    #   rating = Urban Spoon rating
    #   items = Number of items under the specified price range
    #   proximity = distance in meters from the source
    #   median = median price of all the items in the restaurant
    # Sorry if my math is shit!
    # I'm sure this could be improved but for an MVP it should be enough
    def self.rank(rating, items, proximity, median)
        # Reduce the effectiveness of the no. of items
        items_graded = items*0.5 + 0.5
        # Reduce the effectiveness of the median price
        median_graded = median*0.15
        # Run the equation
        return (rating*items_graded)/(proximity*median_graded)
    end

    def site_content(url)
        Nokogiri::HTML(open("http://www.urbanspoon.com" + url));
    end

    def restaurant_name(url)
        # Restaurant name is the only h1 on the page :)
        site_content(url).css('h1 a').each do |name|
            @content[:name] = name.content
        end
    end

    def address(url)
        # Need to concatinate street and locality
        full_address = ''

        # Get street address
        site_content(url).css('span.street-address').each do |street_address|
            full_address << street_address.text.strip
        end

        # Get locality
        site_content(url).css('span.locality').each do |locality|
            full_address << " " + locality.text.strip
            full_address = full_address.split(',')[0]
        end

        # Add full_address to the hash
        @content[:address] = full_address
    end

    def hours(url)
        open_hours = ""
        site_content(url).css('div#hours-base').each do |hours|
            open_hours << hours.children.text.gsub("\n", " ").gsub("Hours", "").strip
        end
        @content[:open_hours] = open_hours
    end

    def rating(url)
        site_content(url).css('div.rating').each do |rating|
            @content[:rating] = rating.text.to_f
        end
    end

    def uri(url)
        @content[:uri] = url
    end

    def get_list(page)
        list = []
        url = "http://www.urbanspoon.com/pr/71/1/Melbourne/Cheap-Eats.html?page=" + page.to_s
        site = Nokogiri::HTML(open(url))
        site.css('a.resto_name').each do |restaurant|
            list.push(restaurant.attributes['href'].value)
        end
        list
    end

    def get_details(url)
        @content = Hash.new
        self.restaurant_name(url)
        self.address(url)
        self.hours(url)
        self.rating(url)
        self.uri(url)
        @content
    end

    def get_ratings(url)
        @content = Hash.new
            self.rating(url)
        @content
    end


end
