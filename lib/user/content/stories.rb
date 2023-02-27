module Stories
    # === Duplicate story.
    # Duplicate a story.
    #
    # ==== Parameters
    # id:: (Integer) -- Story id.
    # data:: (Hash) -- Data to be submitted.
    #
    # ==== Example
    #     data = {
    #       "options": [] 
    #     }
    #     @data = @mints_user.duplicate_story(1, data.to_json)
    def duplicate_story(id, data)
        @client.raw("post", "/content/stories/#{id}/duplicate", nil, data)
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
    #       "fields": "id, slug"
    #     }
    #     @data = @mints_user.get_stories(options)
    #
    # ==== Third Example
    #     options = {
    #       "fields": "id, slug"
    #     }
    #     @data = @mints_user.get_stories(options, true)
    def get_stories(options = nil, use_post = true)
        get_query_results("/content/stories", options, use_post)
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
    #       "fields": "id, slug"
    #     }
    #     @data = @mints_user.get_story(1, options)
    def get_story(id, options = nil)
        @client.raw("get", "/content/stories/#{id}", options)
    end

    # === Create story.
    # Create a story with data.
    #
    # ==== Parameters
    # data:: (Hash) -- Data to be submitted.
    #
    # ==== Example
    #     data = {
    #       "user_id": 1,
    #       "slug": "new-story",
    #       "story_template_id": 1
    #     }
    #     @data = @mints_user.create_story(data)
    def create_story(data)
        @client.raw("post", "/content/stories", nil, data_transform(data))
    end

    # === Update story.
    # Update a story info.
    #
    # ==== Parameters
    # id:: (Integer) -- Story id.
    # data:: (Hash) -- Data to be submitted.
    #
    # ==== Example
    #     data = {
    #       "user_id": 1,
    #       "slug": "new-story"
    #     }
    #     @data = @mints_user.update_story(5, data)
    def update_story(id, data)
        @client.raw("put", "/content/stories/#{id}", nil, data_transform(data))
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
        @client.raw("delete", "/content/stories/#{id}")
    end
end