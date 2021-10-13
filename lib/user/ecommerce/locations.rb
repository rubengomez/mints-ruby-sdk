module Locations
    ##
    # == Locations
    #

    # === Get locations.
    # Get a collection of locations.
    #
    # ==== Parameters
    # use_post:: (Boolean) -- Variable to determine if the request is by 'post' or 'get' functions.
    #
    # ==== First Example
    #     @data = @mints_user.get_locations
    #
    # ==== Second Example
    #     @data = @mints_user.get_locations(false)
    def get_locations(use_post = true)
        return get_query_results("/ecommerce/locations", nil, use_post)
    end
    
    # === Get location.
    # Get a location info.
    #
    # ==== Parameters
    # id:: (Integer) -- Location id.
    #
    # ==== Example
    #     @data = @mints_user.get_location(2)
    def get_location(id)
        return @client.raw("get", "/ecommerce/locations/#{id}")
    end

    # === Create location.
    # Create a location with data.
    #
    # ==== Parameters
    # data:: (Hash) -- Data to be submited.
    #
    # ==== Example
    #     data = {
    #       "title": "New Location",
    #       "location_template_id": 1
    #     }
    #     @data = @mints_user.create_location(data)
    def create_location(data)
        return @client.raw("post", "/ecommerce/locations", nil, data_transform(data))
    end

    # === Update location.
    # Update a location info.
    #
    # ==== Parameters
    # id:: (Integer) -- Location id.
    # data:: (Hash) -- Data to be submited.
    #
    # ==== Example
    #     data = {
    #       "title": "New Location Modified"
    #     }
    #     @data = @mints_user.update_location(5, data.to_json)
    def update_location(id, data)
        return @client.raw("put", "/ecommerce/locations/#{id}", nil, data)
    end

    # === Delete location.
    # Delete a location.
    #
    # ==== Parameters
    # id:: (Integer) -- Location id.
    #
    # ==== Example
    #     @data = @mints_user.delete_location(5)
    def delete_location(id)
        return @client.raw("delete", "/ecommerce/locations/#{id}")
    end

    ##
    # == Locations Templates
    #

    # === Get location template support data.
    # Get support data used in a location template.
    #
    # ==== Parameters
    # id:: (Integer) -- Location template id.
    #
    # ==== Example
    #     @data = @mints_user.get_location_template_support_data(1)
    def get_location_template_support_data(id)
        return @client.raw("get", "/ecommerce/location-templates/#{id}/support-data")
    end
    
    # === Get location templates support data.
    # Get support data used in location templates.
    #
    # ==== Example
    #     @data = @mints_user.get_location_templates_support_data
    def get_location_templates_support_data
        return @client.raw("get", "/ecommerce/location-templates/support-data")
    end

    # === Get location templates.
    # Get a collection of location templates.
    #
    # ==== Parameters
    # options:: (Hash) -- List of Resource Collection Options shown above can be used as parameter.
    #
    # ==== First Example
    #     @data = @mints_user.get_location_templates
    #
    # ==== Second Example
    #     options = { "fields": "title" }
    #     @data = @mints_user.get_location_templates(options)
    def get_location_templates(options = nil)
        return @client.raw("get", "/ecommerce/location-templates", options)
    end

    # === Get location template.
    # Get a location template info.
    #
    # ==== Parameters
    # id:: (Integer) -- Location template id.
    # options:: (Hash) -- List of Resource Collection Options shown above can be used as parameter.
    #
    # ==== First Example
    #     @data = @mints_user.get_location_template(1)
    #
    # ==== Second Example
    #     options = { "fields": "title" }
    #     @data = @mints_user.get_location_template(1, options)
    def get_location_template(id, options = nil)
        return @client.raw("get", "/ecommerce/location-templates/#{id}", options)
    end
    
    # === Create location template.
    # Create a location template with data.
    #
    # ==== Parameters
    # data:: (Hash) -- Data to be submited.
    #
    # ==== Example
    #     data = {
    #       "title": "New Location Template",
    #       "slug": "new-location-template"
    #     }
    #     @data = @mints_user.create_location_template(data)
    def create_location_template(data)
        return @client.raw("post", "/ecommerce/location-templates", nil, data_transform(data))
    end
    
    # === Update location template.
    # Update a location template info.
    #
    # ==== Parameters
    # id:: (Integer) -- Location template id.
    # data:: (Hash) -- Data to be submited.
    #
    # ==== Example
    #     data = {
    #       "title": "New Location Template Modified"
    #     }
    #     @data = @mints_user.update_location_template(3, data)
    def update_location_template(id, data)
        return @client.raw("put", "/ecommerce/location-templates/#{id}", nil, data_transform(data))
    end
end