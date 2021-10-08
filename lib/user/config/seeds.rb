module Seeds
    ##
    # == Seeds
    #

    # === Apply seeds.
    # Apply seeds.
    #
    # ==== Example
    #
    def apply_seeds(data) #TODO: Research use
        return @client.raw("post", "/config/seeds", nil, data)
    end
end