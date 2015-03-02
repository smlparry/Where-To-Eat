require 'nokogiri'
require 'open-uri'

# This class parses the html from the input url
class Parse

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

    def get_list(page = 1)
        list = []
        url = "/pr/71/1/Melbourne/Cheap-Eats.html?page=" + page
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
        @content
    end


end
