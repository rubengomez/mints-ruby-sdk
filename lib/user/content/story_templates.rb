module StoryTemplates
    ##
    # == Story Template
    #

    # === Get support data of story template.
    # Get support data used in a story template.
    #
    # ==== Parameters
    # id:: (Integer) -- Story template id.
    #
    # ==== Example
    #     @data = @mints_user.get_story_template_support_data(1)
    def get_story_template_support_data(id)
        return @client.raw("get", "/content/story-templates/support-data/stories/#{id}")
    end

    # === Get support data of story templates.
    # Get support data used in story templates.
    #
    # ==== Example
    #     @data = @mints_user.get_story_templates_support_data
    def get_story_templates_support_data
        return @client.raw("get", "/content/story-templates/support-data")
    end

    # === Get story templates.
    # Get a collection of story templates.
    #
    # ==== Parameters
    # options:: (Hash) -- List of Resource Collection Options shown above can be used as parameter.
    #
    # ==== First Example
    #     @data = @mints_user.get_story_templates
    #
    # ==== Second Example
    #     options = {
    #       "fields": "id, title"
    #     }
    #     @data = @mints_user.get_story_templates(options)
    def get_story_templates(options = nil)
        return @client.raw("get", "/content/story-templates", options)
    end

    # === Get story template.
    # Get a story template info.
    #
    # ==== Parameters
    # id:: (Integer) -- Story template id.
    # options:: (Hash) -- List of Resource Collection Options shown above can be used as parameter.
    #
    # ==== First Example
    #     @data = @mints_user.get_story_template(2)
    #
    # ==== Second Example
    #     options = {
    #       "fields": "title"
    #     }
    #     @data = @mints_user.get_story_template(1, options)
    def get_story_template(id, options = nil)
        return @client.raw("get", "/content/story-templates/#{id}", options)
    end

    # === Create story template.
    # Create a story template with data.
    #
    # ==== Parameters
    # data:: (Hash) -- Data to be submited.
    #
    # ==== Example
    #     data = {
    #       "title": "New Story Template",
    #       "slug": "new-story-template-slug"
    #     }
    #     @data = @mints_user.create_story_template(data)
    def create_story_template(data)
        return @client.raw("post", "/content/story-templates", nil, data_transform(data))
    end

    # === Update story template.
    # Update a story template info.
    #
    # ==== Parameters
    # id:: (Integer) -- Story template id.
    # data:: (Hash) -- Data to be submited.
    #
    # ==== Example
    #     data = {
    #       "title": "New Story Template Modified"
    #     }
    #     @data = @mints_user.update_story_template(3, data)
    def update_story_template(id, data)
        return @client.raw("put", "/content/story-templates/#{id}", nil, data_transform(data))
    end
end