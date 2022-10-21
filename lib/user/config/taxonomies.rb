module Taxonomies
    ##
    # == Taxonomies
    #

    # === Sync taxonomies for object.
    # Sync taxonomies for object.
    #
    # ==== Parameters
    # data:: (Hash) -- Data to be submitted.
    #
    # ==== Example
    #     data = {
    #       "object_type": "contacts",
    #       "object_id": 1
    #     }
    #     @data = @mints_user.sync_taxonomies_for_object(data)
    def sync_taxonomies_for_object(data)
        return @client.raw("put", "/config/taxonomies/sync_taxonomies_for_object", nil, data_transform(data))
    end

    # === Get taxonomies for object.
    # Get taxonomies for object.
    #
    # ==== Parameters
    # options:: (Hash) -- List of Resource Collection Options shown above can be used as parameter.
    #
    # ==== Example
    #     options = {
    #       "object_type": "contacts",
    #       "object_id": 1
    #     }
    #     @data = @mints_user.get_taxonomies_for_object(options)
    def get_taxonomies_for_object(options)
        return @client.raw("get", "/config/taxonomies/get_taxonomies_for_object", options)
    end
    
    # === Get taxonomies support data.
    # Get support data used in taxonomies.
    #
    # ==== Example
    #     @data = @mints_user.get_taxonomies_support_data
    def get_taxonomies_support_data
        return @client.raw("get", "/config/taxonomies/support-data")
    end
    
    #FIXME: Method doesnt exist in TaxonomyController.getUISupportData
    #def get_ui_taxonomy(id)
    #  return @client.raw("get", "/config/taxonomies/ui-taxonomies/#{id}")
    #end
    
    # === Get taxonomies.
    # Get a collection of taxonomies.
    #
    # ==== Parameters
    # options:: (Hash) -- List of Resource Collection Options shown above can be used as parameter.
    # use_post:: (Boolean) -- Variable to determine if the request is by 'post' or 'get' functions.
    #
    # ==== First Example
    #     @data = @mints_user.get_taxonomies
    #
    # ==== Second Example
    #     options = { "fields": "title" }
    #     @data = @mints_user.get_taxonomies(options)
    #
    # ==== Third Example
    #     options = { "fields": "title" }
    #     @data = @mints_user.get_taxonomies(options, false)
    def get_taxonomies(options = nil, use_post = true)
        return get_query_results("/config/taxonomies", options, use_post)
    end

    # === Get taxonomy.
    # Get a taxonomy info.
    #
    # ==== Parameters
    # id:: (Integer) -- Taxonomy id.
    # options:: (Hash) -- List of Resource Collection Options shown above can be used as parameter.
    #
    # ==== First Example
    #     @data = @mints_user.get_taxonomy(1)
    #
    # ==== Second Example
    #     options = { "fields": "title" }
    #     @data = @mints_user.get_taxonomy(1, options)
    def get_taxonomy(id, options = nil)
        return @client.raw("get", "/config/taxonomies/#{id}", options)
    end

    # === Create taxonomy.
    # Create a taxonomy with data.
    #
    # ==== Parameters
    # data:: (Hash) -- Data to be submitted.
    #
    # ==== Example
    #     data = {
    #       "title": "New Taxonomy",
    #       "slug": "new-taxonomy",
    #       "object_type": "contacts"
    #     }
    #     @data = @mints_user.create_taxonomy(data)
    def create_taxonomy(data, options = nil)
        return @client.raw("post", "/config/taxonomies", options, data_transform(data))
    end
    
    # === Update taxonomy.
    # Update a taxonomy info.
    #
    # ==== Parameters
    # id:: (Integer) -- Taxonomy id.
    # data:: (Hash) -- Data to be submitted.
    #
    # ==== Example
    #     data = {
    #       "title": "New Taxomony Modified",
    #       "slug": "new-taxonomy",
    #       "object_type": "contacts"
    #     }
    #     @data = @mints_user.update_taxonomy(104, data)
    def update_taxonomy(id, data, options = nil)
        return @client.raw("put", "/config/taxonomies/#{id}", options, data_transform(data))
    end
end