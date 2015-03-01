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

        @content
    end


end
