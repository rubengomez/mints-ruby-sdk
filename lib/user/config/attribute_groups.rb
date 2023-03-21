module AttributeGroups
    ##
    # == Attribute Groups
    #

    # === Get attribute groups data types.
    # Get data types used in attribute groups.
    #
    # ==== Example
    #     @data = @mints_user.get_attribute_groups_data_types
    def get_attribute_groups_data_types
        @client.raw('get', "/config/attribute-groups/object-types")
    end

    # === Get attribute groups.
    # Get a collection of attribute groups.
    #
    # ==== Parameters
    # options:: (Hash) -- List of Resource Collection Options shown above can be used as parameter.
    #
    # ==== First Example
    #     @data = @mints_user.get_attribute_groups
    #
    # ==== Second Example
    #     options = { sort: "id" }
    #     @data = @mints_user.get_attribute_groups(options)
    def get_attribute_groups(options = nil)
        @client.raw('get', "/config/attribute-groups", options)
    end
    
    # === Get attribute group.
    # Get an attribute group info.
    #
    # ==== Parameters
    # id:: (Integer) -- Attribute group id.
    #
    # ==== Example
    #     @data = @mints_user.get_attribute_group(10)
    def get_attribute_group(id)
        @client.raw('get', "/config/attribute-groups/#{id}")
    end

    # === Create attribute group.
    # Create an attribute group with data.
    #
    # ==== Parameters
    # data:: (Hash) -- Data to be submitted.
    #
    # ==== Example
    #     data = {
    #       title: "New Attribute Group",
    #       "object_type": "contacts"
    #     }
    #     @data = @mints_user.create_attribute_group(data)
    def create_attribute_group(data)
        @client.raw('post', "/config/attribute-groups", nil, data_transform(data))
    end

    # === Update attribute group.
    # Update an attribute group info.
    #
    # ==== Parameters
    # id:: (Integer) -- Attribute group id.
    # data:: (Hash) -- Data to be submitted.
    #
    # ==== Example
    #     data = {
    #       title: "New Attribute Group Modified",
    #       "object_type": "contacts",
    #       slug: "new-attribute-group",
    #       description: "New description"
    #     }
    #     @data = @mints_user.update_attribute_group(36, data)
    def update_attribute_group(id, data)
        @client.raw('put', "/config/attribute-groups/#{id}", nil, data_transform(data))
    end
end