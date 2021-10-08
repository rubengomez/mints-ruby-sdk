module PriceList
    ##
    # == Price List
    #

    # === Get price lists.
    # Get a collection of price lists.
    #
    # ==== Parameters
    # options:: (Hash) -- List of Resource Collection Options shown above can be used as parameter.
    #
    # ==== First Example
    #     @data = @mints_user.get_price_lists
    #
    # ==== Second Example
    #     options = {
    #       "fields": "title"
    #     }
    #     @data = @mints_user.get_price_lists(options)
    def get_price_lists(options = nil)
        return get_query_results("/ecommerce/price-list", options)
    end

    # === Get price list.
    # Get a price list info.
    #
    # ==== Parameters
    # id:: (Integer) -- Price list id.
    # options:: (Hash) -- List of Resource Collection Options shown above can be used as parameter.
    #
    # ==== First Example
    #     @data = @mints_user.get_price_list(1)
    #
    # ==== Second Example
    #     options = {
    #       "fields": "title"
    #     }
    #     @data = @mints_user.get_price_list(1, options)
    def get_price_list(id, options = nil)
        return @client.raw("get", "/ecommerce/price-list/#{id}", options)
    end

    # === Create price list.
    # Create a price list with data.
    #
    # ==== Parameters
    # data:: (Hash) -- Data to be submited.
    #
    # ==== Example
    #     data = {
    #       "title": "New Price List"
    #     }
    #     @data = @mints_user.create_price_list(data)
    def create_price_list(data)
        return @client.raw("post", "/ecommerce/price-list", nil, data_transform(data))
    end

    # === Update price list.
    # Update a price list info.
    #
    # ==== Parameters
    # id:: (Integer) -- Price list id.
    # data:: (Hash) -- Data to be submited.
    #
    # ==== Example
    #     data = {
    #       "title": "New Price List Modified"
    #     }
    #     @data = @mints_user.update_price_list(8, data)
    def update_price_list(id, data)
        return @client.raw("put", "/ecommerce/price-list/#{id}", nil, data_transform(data))
    end
end