module ContentInstances
    ##
    # == Content Instances
    #

    # === Get content instances.
    # Get a collection of content instances.
    #
    # ==== Parameters
    # options:: (Hash) -- List of Resource Collection Options shown above can be used as parameter.
    #
    # ==== First Example
    #     @data = @mints_user.get_content_instances
    #
    # ==== Second Example
    #     options = { "fields": "id" }
    #     @data = @mints_user.get_content_instances(options)
    def get_content_instances(options = nil)
        return @client.raw("get", "/content/instances", options)
    end

    # === Duplicate content instance.
    # Duplicate a content instance.
    #
    # ==== Parameters
    # id:: (Integer) -- Content instance id.
    # data:: (Hash) -- Data to be submited.
    #
    # ==== Example
    #     data = { 
    #       "options": [] 
    #     }
    #     @data = @mints_user.duplicate_content_instance(1, data.to_json)
    def duplicate_content_instance(id, data)
        return @client.raw("post", "/content/instances/#{id}/duplicate", nil, data)
    end
    
    # === Get content instance.
    # Get a content instance info.
    #
    # ==== Parameters
    # id:: (Integer) -- Content instance id.
    # options:: (Hash) -- List of Resource Collection Options shown above can be used as parameter.
    #
    # ==== First Example
    #     @data = @mints_user.get_content_instance(1)
    #
    # ==== Second Example
    #     options = { "fields": "id, title" }
    #     @data = @mints_user.get_content_instance(1, options)
    def get_content_instance(id, options = nil)
        return @client.raw("get", "/content/instances/#{id}", options)
    end

    # === Publish content instance.
    # Publish a content instance.
    #
    # ==== Parameters
    # id:: (Integer) -- Content instance id.
    # data:: (Hash) -- Data to be submited.
    #
    # ==== Example
    #     data = {
    #       "title": "New publish",
    #       "slug": "new-publish",
    #       "content_template_id": 1
    #     }
    #     @data = @mints_user.publish_content_instance(2, data)
    def publish_content_instance(id, data)
        return @client.raw("put", "/content/instances/#{id}/publish", nil, data_transform(data))
    end

    # === Schedule content instance.
    # Schedule a content instance in a specified date.
    #
    # ==== Parameters
    # id:: (Integer) -- Content instance id.
    # data:: (Hash) -- Data to be submited.
    #
    # ==== Example
    #     data = { 
    #       "scheduled_at": "2021-09-06T20:29:16+00:00"
    #     }
    #     @data = @mints_user.schedule_content_instance(1, data)
    def schedule_content_instance(id, data)
        return @client.raw("put", "/content/instances/#{id}/schedule", nil, data_transform(data))
    end

    # === Revert published content instance.
    # Revert a published content instance.
    #
    # ==== Parameters
    # id:: (Integer) -- Content instance id.
    #
    # ==== Example
    #     @data = @mints_user.revert_published_content_instance(1)
    def revert_published_content_instance(id)
        return @client.raw("get", "/content/instances/#{id}/revert-published-data")
    end

    # === Create content instance.
    # Create a content instance with data.
    #
    # ==== Parameters
    # data:: (Hash) -- Data to be submited.
    #
    # ==== Example
    #     data = {
    #       "title": "New Content Instance",
    #       "content_template_id": 1,
    #       "slug": "new-content-instance-slug"
    #     }
    #     @data = @mints_user.create_content_instance(data)
    def create_content_instance(data)
        return @client.raw("post", "/content/instances",  nil, data_transform(data))
    end

    # === Update content instance.
    # Update a content instance info.
    #
    # ==== Parameters
    # id:: (Integer) -- Content instance id.
    # data:: (Hash) -- Data to be submited.
    #
    # ==== Example
    #     data = {
    #       "title": "New Content Instance Modified",
    #       "content_template_id": 1,
    #       "slug": "new-content-instance-slug"
    #     }
    #     @data = @mints_user.update_content_instance(18, data)
    def update_content_instance(id, data)
        return @client.raw("put", "/content/instances/#{id}", nil, data_transform(data))
    end

    # === Delete content instance.
    # Delete a content instance.
    #
    # ==== Parameters
    # id:: (Integer) -- Content instance id.
    #
    # ==== Example
    #     @data = @mints_user.delete_content_instance(20)
    def delete_content_instance(id)
        return @client.raw("delete", "/content/instances/#{id}")
    end
end