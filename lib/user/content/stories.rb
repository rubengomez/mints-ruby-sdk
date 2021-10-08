module Stories
    ##
    # == Story
    #

    # === Publish story.
    # Publish a story.
    #
    # ==== Parameters
    # id:: (Integer) -- Story id.
    # data:: (Hash) -- Data to be submited.
    #
    # ==== Example
    #     data = {
    #       "scheduled_at": "2021-09-06T20:29:16+00:00"
    #     }
    #     @data = @mints_user.publish_story(2, data)
    def publish_story(id, data)
        return @client.raw("put", "/content/stories/#{id}/publish", nil, data_transform(data))
    end

    # === Schedule story.
    # Schedule a story in a specified date.
    #
    # ==== Parameters
    # id:: (Integer) -- Story id.
    # data:: (Hash) -- Data to be submited.
    #
    # ==== Example
    #     data = {
    #       "scheduled_at": "2021-09-06T20:29:16+00:00"
    #     }
    #     @data = @mints_user.schedule_story(1, data)
    def schedule_story(id, data)
        return @client.raw("put", "/content/stories/#{id}/schedule", nil, data_transform(data))
    end

    # === Revert published story.
    # Revert a published story.
    #
    # ==== Parameters
    # id:: (Integer) -- Story id.
    #
    # ==== Example
    #     @data = @mints_user.revert_published_story(1)
    def revert_published_story(id)
        return @client.raw("get", "/content/stories/#{id}/revert-published-data")
    end

    # === Get stories support data.
    # Get support data used in stories.
    #
    # ==== Example
    #     @data = @mints_user.get_stories_support_data
    def get_stories_support_data
        return @client.raw("get", "/content/stories/support-data")
    end

    # === Duplicate story.
    # Duplicate a story.
    #
    # ==== Parameters
    # id:: (Integer) -- Story id.
    # data:: (Hash) -- Data to be submited.
    #
    # ==== Example
    #     data = {
    #       "options": [] 
    #     }
    #     @data = @mints_user.duplicate_story(1, data.to_json)
    def duplicate_story(id, data)
        return @client.raw("post", "/content/stories/#{id}/duplicate", nil, data)
    end

    # === Get stories.
    # Get a collection of stories.
    #
    # ==== Parameters
    # options:: (Hash) -- List of Resource Collection Options shown above can be used as parameter.
    # use_post:: (Boolean) -- Variable to determine if the request is by 'post' or 'get' functions.
    #
    # ==== First Example
    #     @data = @mints_user.get_stories
    #
    # ==== Second Example
    #     options = {
    #       "fields": "id, title"
    #     }
    #     @data = @mints_user.get_stories(options)
    #
    # ==== Third Example
    #     options = {
    #       "fields": "id, title"
    #     }
    #     @data = @mints_user.get_stories(options, true)
    def get_stories(options = nil, use_post = true)
        return get_query_results("/content/stories", options, use_post)
    end

    # === Get story.
    # Get a story info.
    #
    # ==== Parameters
    # id:: (Integer) -- Story id.
    # options:: (Hash) -- List of Resource Collection Options shown above can be used as parameter.
    #
    # ==== First Example
    #     @data = @mints_user.get_story(1)
    #
    # ==== Second Example
    #     options = {
    #       "fields": "id, title"
    #     }
    #     @data = @mints_user.get_story(1, options)
    def get_story(id, options = nil)
        return @client.raw("get", "/content/stories/#{id}", options)
    end

    # === Create story.
    # Create a story with data.
    #
    # ==== Parameters
    # data:: (Hash) -- Data to be submited.
    #
    # ==== Example
    #     data = {
    #       "title": "New Story",
    #       "slug": "new-story",
    #       "social_metadata": "social metadata"
    #     }
    #     @data = @mints_user.create_story(data)
    def create_story(data)
        return @client.raw("post", "/content/stories", nil, data_transform(data))
    end

    # === Update story.
    # Update a story info.
    #
    # ==== Parameters
    # id:: (Integer) -- Story id.
    # data:: (Hash) -- Data to be submited.
    #
    # ==== Example
    #     data = {
    #       "title": "New Story Modified",
    #       "slug": "new-story"
    #     }
    #     @data = @mints_user.update_story(5, data)
    def update_story(id, data)
        return @client.raw("put", "/content/stories/#{id}", nil, data_transform(data))
    end

    # === Delete story.
    # Delete a story.
    #
    # ==== Parameters
    # id:: (Integer) -- Story id.
    #
    # ==== Example
    #     @data = @mints_user.delete_story(6)
    def delete_story(id)
        return @client.raw("delete", "/content/stories/#{id}")
    end
end