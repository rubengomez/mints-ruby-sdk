module VariantValues
    ##
    # == Variant Values
    #
    
    # === Get variant values.
    # Get a collection of variant values.
    #
    # ==== Parameters
    # options:: (Hash) -- List of Resource Collection Options shown above can be used as parameter.
    #
    # ==== First Example
    #     @data = @mints_user.get_variant_values
    #
    # ==== Second Example
    #     options = { "sort": "-id"}
    #     @data = @mints_user.get_variant_values(options)
    def get_variant_values(options = nil)
        return @client.raw("get", "/ecommerce/variant-values", options)
    end
    
    # === Get variant value.
    # Get a variant value info.
    #
    # ==== Parameters
    # id:: (Integer) -- Variant value id.
    # options:: (Hash) -- List of Resource Collection Options shown above can be used as parameter.
    #
    # ==== First Example
    #     @data = @mints_user.get_variant_value(5)
    #
    # ==== Second Example
    #     options = { "fields": "id"}
    #     @data = @mints_user.get_variant_value(5, options)
    def get_variant_value(id, options = nil)
        return @client.raw("get", "/ecommerce/variant-values/#{id}", options)
    end

    # === Create variant value.
    # Create a variant value with data.
    #
    # ==== Parameters
    # data:: (Hash) -- Data to be submitted.
    #
    # ==== Example
    #     data = {
    #       "value": "New Variant Value",
    #       "variant_option_id": 1,
    #       "display_order": 1,
    #       "sku_code": "new-variant-value-sku"
    #     }
    #     @data = @mints_user.create_variant_value(data)
    def create_variant_value(data)
        return @client.raw("post", "/ecommerce/variant-values", nil, data_transform(data))
    end

    # === Update variant value.
    # Update a variant value info.
    #
    # ==== Parameters
    # id:: (Integer) -- Variant value id.
    # data:: (Hash) -- Data to be submitted.
    #
    # ==== Example
    #     data = {
    #       "value": "New Variant Value Modified"
    #     }
    #     @data = @mints_user.update_variant_value(22, data)
    def update_variant_value(id, data)
        return @client.raw("put", "/ecommerce/variant-values/#{id}", nil, data_transform(data))
    end
end