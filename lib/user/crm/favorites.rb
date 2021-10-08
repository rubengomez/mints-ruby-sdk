module Favorites
    ##
    # == Favorites #TODO: NOT CHECKED, NO DATA IN DB
    #

    def update_multiple_favorites(data)
        return @client.raw("put", "/crm/favorites", nil, data)
    end

    def get_favorites(options = nil)
        return @client.raw("get", "/crm/favorites", options)
    end

    def update_favorites(id, data)
        return @client.raw("put", "/crm/favorites/#{id}", nil, data)
    end
end