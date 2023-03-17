module ObjectActivities
    ##
    # == Object Activities
    #

    # === Get object activities.
    # Get a collection of object activities.
    #
    # ==== Parameters
    # options:: (Hash) -- List of Resource Collection Options shown above can be used as parameter.
    #
    # ==== First Example
    #     @data = @mints_user.get_object_activities
    #
    # ==== Second Example
    #     options = { "fields": "object_type" }
    #     @data = @mints_user.get_object_activities(options)
    def get_object_activities(options = nil)
        @client.raw("get", "/helpers/object-activities", options)
    end

    # === Get object activity.
    # Get an object activity.
    #
    # ==== Parameters
    # id:: (Integer) -- Object activity id.
    # options:: (Hash) -- List of Resource Collection Options shown above can be used as parameter.
    #
    # ==== First Example
    #     @data = @mints_user.get_object_activity(1)
    #
    # ==== Second Example
    #     options = { "fields": "activity_type" }
    #     @data = @mints_user.get_object_activity(1, options)
    def get_object_activity(id, options = nil)
        @client.raw("get", "/helpers/object-activities/#{id}", options)
    end

    # === Create object activity.
    # Create an object activity with data.
    #
    # ==== Parameters
    # data:: (Hash) -- Data to be submitted.
    #
    # ==== Example
    #     data = {
    #       "activity_type": "note",
    #       "object_type": "contacts",
    #       "object_id": 1
    #     }
    #     @data = @mints_user.create_object_activity(data)
    def create_object_activity(data)
        @client.raw("post", "/helpers/object-activities", nil, data_transform(data))
    end
    
    # === Update object activity.
    # Update an object activity info.
    #
    # ==== Parameters
    # id:: (Integer) -- Object activity id.
    # data:: (Hash) -- Data to be submitted.
    #
    # ==== Example
    #     data = {
    #       "activity_type": "ticket"
    #     }
    #     @data = @mints_user.update_object_activity(573, data)
    def update_object_activity(id, data)
        @client.raw("put", "/helpers/object-activities/#{id}", nil, data_transform(data))
    end

    # === Delete object activity.
    # Delete an object activity.
    #
    # ==== Parameters
    # id:: (Integer) -- Object activity id.
    #
    # ==== Example
    #     @data = @mints_user.delete_object_activity(573)
    def delete_object_activity(id)
        @client.raw("delete", "/helpers/object-activities/#{id}")
    end
end