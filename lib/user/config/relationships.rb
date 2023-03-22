module Relationships
    ##
    # == Relationships
    #
    
    # === Get relationships available for.
    # Get relationships available.
    #
    # ==== Parameters
    # options:: (Hash) -- List of Resource Collection Options shown above can be used as parameter.
    #
    # ==== Example
    #     options = {
    #       "objectType": "contacts"
    #     }
    #     @data = @mints_user.get_relationships_available_for(options)
    def get_relationships_available_for(options)
        @client.raw('get', "/config/relationships/available-for", options)
    end
    
    # === Attach relationship.
    # Attach a relationship.
    #
    # ==== Parameters
    # data:: (Hash) -- Data to be submitted.
    #
    # ==== Example
    #     
    def attach_relationship(data) #FIXME: Method doesn't work, RelationshipManager cannot access to id attribute.
        @client.raw('post', "/config/relationships/attach", nil, data_transform(data))
    end

    # === Detach relationship.
    # Detach a relationship.
    #
    # ==== Parameters
    # data:: (Hash) -- Data to be submitted.
    #
    # ==== Example
    #     
    def detach_relationship(data) #FIXME: Method doesn't work, RelationshipManager cannot access to id attribute.
        @client.raw('post', "/config/relationships/detach", nil, data_transform(data))
    end
    
    # === Relationship has objects.
    # Get relationships that has objects.
    #
    # ==== Parameters
    # id:: (Integer) -- Relationship id.
    #
    # ==== Example
    #     @data = @mints_user.relationship_has_objects(1)
    def relationship_has_objects(id)
        @client.raw('get', "/config/relationships/#{id}/hasObjects")
    end
    
    # === Get relationships.
    # Get a collection of relationships.
    #
    # ==== Parameters
    # options:: (Hash) -- List of Resource Collection Options shown above can be used as parameter.
    #
    # ==== First Example
    #     @data = @mints_user.get_relationships
    #
    # ==== Second Example
    #     options = { fields: "id" }
    #     @data = @mints_user.get_relationships(options)
    def get_relationships(options = nil)
        @client.raw('get', "/config/relationships", options)
    end

    # === Get relationship.
    # Get a relationship info.
    #
    # ==== Parameters
    # id:: (Integer) -- Relationship id.
    # options:: (Hash) -- List of Resource Collection Options shown above can be used as parameter.
    #
    # ==== First Example
    #     @data = @mints_user.get_relationship(1)
    #
    # ==== Second Example
    #     options = { fields: "id" }
    #     @data = @mints_user.get_relationship(1, options)
    def get_relationship(id, options = nil)
        @client.raw('get', "/config/relationships/#{id}", options)
    end

    # === Create relationship.
    # Create a relationship with data.
    #
    # ==== Parameters
    # data:: (Hash) -- Data to be submitted.
    #
    # ==== Example
    #     data = {
    #       "alias_1": "eventsCopy",
    #       "alias_2": "ticketsCopy",
    #       "object_model_1": "Story",
    #       "object_model_2": "Product"
    #     }
    #     @data = @mints_user.create_relationship(data)
    def create_relationship(data)
        @client.raw('post', "/config/relationships", nil, data_transform(data))
    end

    # === Update relationship.
    # Update a relationship info.
    #
    # ==== Parameters
    # id:: (Integer) -- Relationship id.
    # data:: (Hash) -- Data to be submitted.
    #
    # ==== Example
    #     data = {
    #       "alias_1": "eventsCopyModified",
    #       "alias_2": "ticketsCopyModified",
    #       "object_model_1": "Story",
    #       "object_model_2": "Product"
    #     }
    #     @data = @mints_user.update_relationship(5, data)
    def update_relationship(id, data)
        @client.raw('put', "/config/relationships/#{id}", nil, data_transform(data))
    end

    # === Delete relationship.
    # Delete a relationship.
    #
    # ==== Parameters
    # id:: (Integer) -- Relationship id.
    #
    # ==== Example
    #     @data = @mints_user.delete_relationship(5)
    def delete_relationship(id)
        @client.raw('delete', "/config/relationships/#{id}")
    end
end