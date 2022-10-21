module ItemPrices
    ##
    # == Item Prices
    #

    # === Get item prices.
    # Get a collection of item prices.
    #
    # ==== Parameters
    # options:: (Hash) -- List of Resource Collection Options shown above can be used as parameter.
    #
    # ==== First Example
    #     @data = @mints_user.get_item_prices
    #
    # ==== Second Example
    #     options = { "fields": "price_cents" }
    #     @data = @mints_user.get_item_prices(options)
    def get_item_prices(options = nil)
        return @client.raw("get", "/ecommerce/item-prices", options)
    end

    # === Get item price.
    # Get a item price info.
    #
    # ==== Parameters
    # id:: (Integer) -- Item price id.
    # options:: (Hash) -- List of Resource Collection Options shown above can be used as parameter.
    #
    # ==== First Example
    #     @data = @mints_user.get_item_price(1)
    #
    # ==== Second Example
    #     options = { "fields": "price_cents" }
    #     @data = @mints_user.get_item_price(1, options)
    def get_item_price(id, options = nil)
        return @client.raw("get", "/ecommerce/item-prices/#{id}", options)
    end

    # === Create item price.
    # Create a item price with data.
    #
    # ==== Parameters
    # data:: (Hash) -- Data to be submitted.
    #
    # ==== Example
    #     data = {
    #       "price_list": [
    #         { "id": 1 },
    #         { "id": 2 }
    #       ],
    #       "price_list_id": 1,
    #       "title": "New Item Price"
    #     }
    #     @data = @mints_user.create_item_price(data)
    def create_item_price(data) #FIXME: Api send sku_id as null and DB doesnt allow that.
        return @client.raw("post", "/ecommerce/item-prices", nil, data_transform(data))
    end

    # === Update item price.
    # Update a item price info.
    #
    # ==== Parameters
    # id:: (Integer) -- Order item price id.
    # data:: (Hash) -- Data to be submitted.
    #
    # ==== Example
    #     data = {
    #       "price": 12345
    #     }
    #     @data = @mints_user.update_item_price(1, data)
    def update_item_price(id, data)
        return @client.raw("put", "/ecommerce/item-prices/#{id}", nil, data_transform(data))
    end
    
    # === Delete item price.
    # Delete a item price.
    #
    # ==== Parameters
    # id:: (Integer) -- Item price id.
    #
    # ==== Example
    #     @data = @mints_user.delete_item_price(803)
    def delete_item_price(id)
        return @client.raw("delete", "/ecommerce/item-prices/#{id}")
    end
end