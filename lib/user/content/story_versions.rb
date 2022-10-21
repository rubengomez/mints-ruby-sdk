module StoryVersions
    # === Get story versions.
    # Get a collection of story versions.
    #
    # ==== Parameters
    # options:: (Hash) -- List of Resource Collection Options shown above can be used as parameter.
    # use_post:: (Boolean) -- Variable to determine if the request is by 'post' or 'get' functions.
    #
    # ==== First Example
    #     @data = @mints_user.get_story_versions
    #
    # ==== Second Example
    #     options = {
    #       "fields": "id, title"
    #     }
    #     @data = @mints_user.get_story_versions(options)
    #
    # ==== Third Example
    #     options = {
    #       "fields": "id, title"
    #     }
    #     @data = @mints_user.get_story_versions(options, true)
    def get_story_versions(options = nil, use_post = true)
        return get_query_results("/content/story-versions", options, use_post)
    end

    # === Get story version.
    # Get a story version info.
    #
    # ==== Parameters
    # id:: (Integer) -- Story version id.
    # options:: (Hash) -- List of Resource Collection Options shown above can be used as parameter.
    #
    # ==== First Example
    #     @data = @mints_user.get_story_version(1)
    #
    # ==== Second Example
    #     options = {
    #       "fields": "id, title"
    #     }
    #     @data = @mints_user.get_story_version(1, options)
    def get_story_version(id, options = nil)
        return @client.raw("get", "/content/story-versions/#{id}", options)
    end

    # === Create story version.
    # Create a story version with data.
    #
    # ==== Parameters
    # data:: (Hash) -- Data to be submitted.
    #
    # ==== Example
    #     data = {
    #       "title": "New Story",
    #       "slug": "new-story",
    #       "social_metadata": "social metadata"
    #     }
    #     @data = @mints_user.create_story_version(data)
    def create_story_version(data, options = nil)
        return @client.raw("post", "/content/story-versions", options, data_transform(data))
    end

    # === Update story version.
    # Update a story version info.
    #
    # ==== Parameters
    # id:: (Integer) -- Story version id.
    # data:: (Hash) -- Data to be submitted.
    #
    # ==== Example
    #     data = {
    #       "title": "New Story Modified",
    #       "slug": "new-story"
    #     }
    #     @data = @mints_user.update_story_version(5, data)
    def update_story_version(id, data, options = nil)
        return @client.raw("put", "/content/story-versions/#{id}", options, data_transform(data))
    end

    # === Delete story version.
    # Delete a story version.
    #
    # ==== Parameters
    # id:: (Integer) -- Story version id.
    #
    # ==== Example
    #     @data = @mints_user.delete_story_version(6)
    def delete_story_version(id)
        return @client.raw("delete", "/content/story-versions/#{id}")
    end

    # === Duplicate story version.
    # Duplicate a story version.
    #
    # ==== Parameters
    # id:: (Integer) -- Story version id.
    # data:: (Hash) -- Data to be submitted.
    #
    # ==== Example
    #     data = {
    #       "options": []
    #     }
    #     @data = @mints_user.duplicate_story_version(1, data.to_json)
    def duplicate_story_version(id, data)
        return @client.raw("post", "/content/story-versions/#{id}/duplicate", nil, data)
    end

    # === Publish story version.
    # Publish a story version.
    #
    # ==== Parameters
    # id:: (Integer) -- Story version id.
    # data:: (Hash) -- Data to be submitted.
    #
    # ==== Example
    #     data = {
    #       "title": "New Story Modified",
    #       "slug": "new-story"
    #     }
    #     @data = @mints_user.publish_story_version(1, data.to_json)
    def publish_story_version(id, data)
        return @client.raw("post", "/content/story-versions/#{id}/publish", nil, data)
    end
end