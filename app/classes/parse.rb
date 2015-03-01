require 'nokogiri'
require 'open-uri'

# This class parses the html from the input url
class Parse

    def initialize
        @content = Hash.new
    end

    def url
        'http://www.urbanspoon.com/r/71/1584177/restaurant/CBD/Manchester-Press-Melbourne'
    end

    def site_content
        Nokogiri::HTML(open(url));
    end

    def restaurant_name
        # Restaurant name is the only h1 on the page :)
        site_content.css('h1 a').each do |name|
            @content[:name] = name.content
        end
    end

    def address
        # Need to concatinate street and locality
        full_address = ''

        # Get street address
        site_content.css('span.street-address').each do |street_address|
            full_address << street_address.text.strip
        end

        # Get locality
        site_content.css('span.locality').each do |locality|
            full_address << " " + locality.text.strip
            full_address = full_address.split(',')[0]
        end

        # Add full_address to the hash
        @content[:address] = full_address
    end

    def do_all
        self.restaurant_name
        self.address
        @content
    end


end
