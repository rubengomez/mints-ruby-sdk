module ContentTemplates
    ##
    # == Content templates
    #

    # === Get content template instances.
    # Get instances of a content template.
    #
    # ==== Parameters
    # templateId:: (Integer) -- Template id.
    #
    # ==== Example
    #     @data = @mints_user.get_content_template_instances(1)
    def get_content_template_instances(templateId)
        @client.raw("get", "/content/templates/#{templateId}/instances")
    end

    # === Duplicate content template.
    # Duplicate a content template.
    #
    # ==== Parameters
    # id:: (Integer) -- Content template id.
    #
    # ==== Example
    #     @data = @mints_user.get_content_template(1)
    def duplicate_content_template(id)
        @client.raw("post", "/content/templates/#{id}/duplicate/")
    end

    # === Get content templates.
    # Get a collection of content templates.
    #
    # ==== Parameters
    # options:: (Hash) -- List of Resource Collection Options shown above can be used as parameter.
    #
    # ==== First Example
    #     @data = @mints_user.get_content_templates
    #
    # ==== Second Example
    #     options = { "sort": "title" }
    #     @data = @mints_user.get_content_templates(options)
    def get_content_templates(options = nil)
        @client.raw("get", "/content/templates", options)
    end

    # === Get content template.
    # Get a content template.
    #
    # ==== Parameters
    # id:: (Integer) -- Content template id.
    #
    # ==== Example
    #     @data = @mints_user.get_content_template(1)
    def get_content_template(id)
        @client.raw("get", "/content/templates/#{id}")
    end

    # === Create content template.
    # Create a content template with data.
    #
    # ==== Parameters
    # data:: (Hash) -- Data to be submitted.
    #
    # ==== Example
    #     data = {
    #       "template": {
    #         "title": "New Content Template",
    #         "slug": "new-content-template-slug",
    #         "description": "New Content Template Description"
    #       }
    #     }
    #     @data = @mints_user.create_content_template(data.to_json)
    def create_content_template(data)
        #TODO: Inform ContentTemplateController.store method has been modified
        @client.raw("post", "/content/templates", nil, data)
    end

    # === Update content template.
    # Update a content template info.
    #
    # ==== Parameters
    # id:: (Integer) -- Content template id.
    # data:: (Hash) -- Data to be submitted.
    #
    # ==== Example
    #     data = {
    #       "template": {
    #         "title": "New Content Template Modified",
    #         "slug": "new-content-template-slug",
    #         "description": "New Content Template Description"
    #       }
    #     }
    #     @data = @mints_user.update_content_template(7, data.to_json)
    def update_content_template(id, data)
         #TODO: Inform ContentTemplateController.update method has been modified
        @client.raw("put", "/content/templates/#{id}", nil, data)
    end

    # === Delete content template.
    # Delete a content template.
    #
    # ==== Parameters
    # id:: (Integer) -- Content template id.
    #
    # ==== Example
    #     @data = @mints_user.delete_content_template(1)
    def delete_content_template(id)
        #TODO: Inform ContentTemplateController.destroy method has been modified
        @client.raw("delete", "/content/templates/#{id}")
    end
end