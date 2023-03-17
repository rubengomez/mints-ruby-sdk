module Attributes
    ##
    # == Attributes
    #

    # === Get attributes data types.
    # Get data types used in attributes.
    #
    # ==== Example
    #     @data = @mints_user.get_attributes_data_types
    def get_attributes_data_types
        @client.raw("get", "/config/attributes/data-types")
    end

    # === Get sub attributes.
    # Get sub attributes with a slug.
    #
    # ==== Parameters
    # options:: (Hash) -- List of Resource Collection Options shown above can be used as parameter.
    #
    # ==== Example
    #     
    def get_sub_attributes(options) #TODO: Test, this method has been added recently
        @client.raw("get", "/config/attributes/sub-attributes", options)
    end
    
    # === Get attributes.
    # Get a collection of attributes.
    #
    # ==== Example
    #     @data = @mints_user.get_attributes
    def get_attributes
        @client.raw("get", "/config/attributes")
    end
    
    # === Get attribute.
    # Get an attribute info.
    #
    # ==== Parameters
    # id:: (Integer) -- Attribute id.
    #
    # ==== Example
    #     @data = @mints_user.get_attribute(1)
    def get_attribute(id)
        @client.raw("get", "/config/attributes/#{id}")
    end

    # === Create attribute.
    # Create an attribute with data.
    #
    # ==== Parameters
    # data:: (Hash) -- Data to be submitted.
    #
    # ==== Example
    #     data = {
    #       "title": "New Attribute",
    #       "object_type": "orders",
    #       "slug": "new_attribute",
    #       "attribute_group_id": 1,
    #       "data_type_enum": 10
    #     }
    #     @data = @mints_user.create_attribute(data)
    def create_attribute(data)
        @client.raw("post", "/config/attributes", nil, data_transform(data))
    end

    # === Update attribute.
    # Update an attribute info.
    #
    # ==== Parameters
    # id:: (Integer) -- Attribute id.
    # data:: (Hash) -- Data to be submitted.
    #
    # ==== Example
    #     data = {
    #       "title": "New Attribute Modified",
    #       "object_type": "orders",
    #       "slug": "new_attribute",
    #       "attribute_group_id": 1,
    #       "data_type_enum": 10
    #     }
    #     @data = @mints_user.update_attribute(292, data)
    def update_attribute(id, data)
        @client.raw("put", "/config/attributes/#{id}", nil, data_transform(data))
    end
end