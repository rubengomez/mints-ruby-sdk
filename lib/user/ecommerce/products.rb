module Products
    ##
    # == Product
    #

    # === Update product variations config.
    # Update config of product variations of a product.
    #
    # ==== Parameters
    # productId:: (Integer) -- Product id.
    # data:: (Hash) -- Data to be submitted.
    #
    def update_product_variations_config(productId, data) #TODO: Method doesnt work, research use
        return @client.raw("post", "/ecommerce/products/update-variations-config/#{productId}", nil, data_transform(data))
    end

    # === Get product support data.
    # Get support data used in products.
    #
    # ==== Example
    #     @data = @mints_user.get_products_support_data
    def get_products_support_data
        return @client.raw("get", "/ecommerce/products/support-data")
    end

    # === Delete product.
    # Delete a product.
    #
    # ==== Parameters
    # id:: (Integer) -- Product id.
    #
    def delete_product(id)
        return @client.raw("delete", "/ecommerce/products/#{id}")
    end
    
    # === Publish product.
    # Publish a product.
    #
    # ==== Parameters
    # id:: (Integer) -- Product id.
    # data:: (Hash) -- Data to be submitted.
    #
    # ==== Example
    #     data = {
    #       "title": "New Publish"
    #     }
    #     @data = @mints_user.publish_product(2, data)
    def publish_product(id, data)
        return @client.raw("put", "/ecommerce/products/#{id}/publish", nil, data_transform(data))
    end

    # === Schedule product.
    # Schedule a product.
    #
    # ==== Parameters
    # id:: (Integer) -- Product id.
    # data:: (Hash) -- Data to be submitted.
    #
    # ==== Example
    #     data = {
    #       "scheduled_at": "1970-01-01 00:00:00"
    #     }
    #     @data = @mints_user.schedule_product(2, data)
    def schedule_product(id, data)
        return @client.raw("put", "/ecommerce/products/#{id}/schedule", nil, data_transform(data))
    end

    # === Get product variant options config.
    # Get variant options config used in a product.
    #
    # ==== Parameters
    # id:: (Integer) -- Product id.
    #
    # ==== Example
    #     @data = @mints_user.get_product_variant_options_config(1)
    def get_product_variant_options_config(id)
        return @client.raw("get", "/ecommerce/products/#{id}/variant-options-config")
    end

    # === Revert published product.
    # Revert a published product.
    #
    # ==== Parameters
    # id:: (Integer) -- Product id.
    #
    # ==== Example
    #     @data = @mints_user.revert_published_product(2)
    def revert_published_product(id)
        return @client.raw("get", "/ecommerce/products/#{id}/revert-published-data")
    end
    
    # === Get products.
    # Get a collection of products.
    #
    # ==== Parameters
    # options:: (Hash) -- List of Resource Collection Options shown above can be used as parameter.
    # use_post:: (Boolean) -- Variable to determine if the request is by 'post' or 'get' functions.
    #
    # ==== First Example
    #     @data = @mints_user.get_products
    #
    # ==== Second Example
    #     options = {
    #       "fields": "id"
    #     }
    #     @data = @mints_user.get_products(options)
    #
    # ==== Third Example
    #     options = {
    #       "fields": "id"
    #     }
    #     @data = @mints_user.get_products(options, false)
    def get_products(options = nil, use_post = true)
        return get_query_results("/ecommerce/products", options, use_post)
    end

    # === Get product.
    # Get a product info.
    #
    # ==== Parameters
    # id:: (Integer) -- Product id.
    # options:: (Hash) -- List of Resource Collection Options shown above can be used as parameter.
    #
    # ==== First Example
    #     @data = @mints_user.get_product(3)
    #
    # ==== Second Example
    #     options = {
    #       "fields": "slug"
    #     }
    #     @data = @mints_user.get_product(3, options)
    def get_product(id, options = nil)
        return @client.raw("get", "/ecommerce/products/#{id}", options)
    end

    # === Create product.
    # Create a product with data.
    #
    # ==== Parameters
    # data:: (Hash) -- Data to be submitted.
    #
    # ==== Example
    #     data = {
    #       "title": "New Product",
    #       "slug": "new-product",
    #       "sku_prefix": "sku_prefix"
    #     }
    #     @data = @mints_user.create_product(data)
    def create_product(data, options = nil)
        return @client.raw("post", "/ecommerce/products/", options, data_transform(data))
    end

    # === Update product.
    # Update a product info.
    #
    # ==== Parameters
    # id:: (Integer) -- Product id.
    # data:: (Hash) -- Data to be submitted.
    #
    # ==== Example
    #     data = {
    #       "title": "New Product Modified",
    #       "slug": "new-product"
    #     }
    #     @data = @mints_user.update_product(9, data)
    def update_product(id, data, options = nil)
        return @client.raw("put", "/ecommerce/products/#{id}", options, data_transform(data))
    end
end