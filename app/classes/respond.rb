class Respond
    def self.no_input
        { error: "You need to supply a price range" }
    end

    def self.no_results
        { error: "Oh no! No results were found."}
    end
end
