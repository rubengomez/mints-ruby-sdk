module Taxes
    ##
    # == Taxes
    #

    # === Get taxes.
    # Get a collection of taxes.
    #
    # ==== Parameters
    # options:: (Hash) -- List of Resource Collection Options shown above can be used as parameter.
    #
    # ==== First Example
    #     @data = @mints_user.get_taxes
    #
    # ==== Second Example
    #     options = { "fields": "title" }
    #     @data = @mints_user.get_taxes(options)
    def get_taxes(options = nil)
        return @client.raw("get", "/ecommerce/taxes", options)
    end

    # === Get tax.
    # Get a tax info.
    #
    # ==== Parameters
    # id:: (Integer) -- Tax id.
    # options:: (Hash) -- List of Resource Collection Options shown above can be used as parameter.
    #
    # ==== First Example
    #     @data = @mints_user.get_tax(1)
    #
    # ==== Second Example
    #     options = { "fields": "title" }
    #     @data = @mints_user.get_tax(1, options)
    def get_tax(id, options = nil)
        return @client.raw("get", "/ecommerce/taxes/#{id}", options)
    end
    
    # === Create tax.
    # Create a tax with data.
    #
    # ==== Parameters
    # data:: (Hash) -- Data to be submited.
    #
    # ==== Example
    #     data = {
    #       "title": "New Tax",
    #       "tax_percentage": 100
    #     }
    #     @data = @mints_user.create_tax(data)
    def create_tax(data)
        return @client.raw("post", "/ecommerce/taxes", nil, data_transform(data))
    end
    
    # === Update tax.
    # Update a tax info.
    #
    # ==== Parameters
    # id:: (Integer) -- Tax id.
    # data:: (Hash) -- Data to be submited.
    #
    # ==== Example
    #     data = {
    #       "tax_percentage": 10
    #     }
    #     @data = @mints_user.update_tax(11, data)
    def update_tax(id, data)
        return @client.raw("put", "/ecommerce/taxes/#{id}", nil, data_transform(data))
    end
    
    # === Delete tax.
    # Delete a tax.
    #
    # ==== Parameters
    # id:: (Integer) -- Tax id.
    #
    # ==== Example
    #     @data = @mints_user.delete_tax(11)
    def delete_tax(id)
        return @client.raw("delete", "/ecommerce/taxes/#{id}")
    end
end