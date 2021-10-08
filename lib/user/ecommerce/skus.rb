module Skus
    ##
    # == Sku
    #

    # === Get skus.
    # Get a collection of skus.
    #
    # ==== Parameters
    # options:: (Hash) -- List of Resource Collection Options shown above can be used as parameter.
    #
    # ==== First Example
    #     @data = @mints_user.get_skus
    #
    # ==== Second Example
    #     options = {
    #       "fields": "sku"
    #     }
    #     @data = @mints_user.get_skus(options)
    def get_skus(options = nil)
        return @client.raw("get", "/ecommerce/skus", options)
    end
    
    # === Get sku.
    # Get a sku info.
    #
    # ==== Parameters
    # id:: (Integer) -- Sku id.
    # options:: (Hash) -- List of Resource Collection Options shown above can be used as parameter.
    #
    # ==== First Example
    #     @data = @mints_user.get_sku(1)
    #
    # ==== Second Example
    #     options = {
    #       "fields": "title, sku"
    #     }
    #     @data = @mints_user.get_sku(1, options)
    def get_sku(id, options = nil)
        return @client.raw("get", "/ecommerce/skus/#{id}", options)
    end

    # === Create sku.
    # Create a sku with data.
    #
    # ==== Parameters
    # data:: (Hash) -- Data to be submited.
    #
    # ==== Example
    #     data = {
    #       "sku": "NEW-SKU-XXXXXX",
    #       "title": "New Sku",
    #       "slug": "new-sku",
    #       "product_id": 1
    #     }
    #     @data = @mints_user.create_sku(data)
    def create_sku(data)
        return @client.raw("post", "/ecommerce/skus", nil, data_transform(data))
    end
    
    # === Update sku.
    # Update a sku info.
    #
    # ==== Parameters
    # id:: (Integer) -- Sku id.
    # data:: (Hash) -- Data to be submited.
    #
    # ==== Example
    #     data = {
    #       "sku": "NEW-SKU-XXXXXY"
    #     }
    #     @data = @mints_user.update_sku(531, data)
    def update_sku(id, data)
        return @client.raw("put", "/ecommerce/skus/#{id}", nil, data_transform(data))
    end
    
    # === Delete sku.
    # Delete a sku.
    #
    # ==== Parameters
    # id:: (Integer) -- Sku id.
    #
    # ==== Example
    #     @data = @mints_user.delete_sku(531)
    def delete_sku(id)
        return @client.raw("delete", "/ecommerce/skus/#{id}")
    end
end