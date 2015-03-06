class Respond
    def self.no_input
        { error: "You need to supply both your location and price range" }
    end

    def self.no_results
        { error: "Oh no! No results were found."}
    end
end
