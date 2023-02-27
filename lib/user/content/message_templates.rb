module MessageTemplates
    ##
    # == Message Template
    #

    # === Get variables of content page from message template.
    # Get variables used in a specified content page located in message templates. 
    #
    # ==== Parameters
    # id:: (Integer) -- Content page id.
    #
    # ==== Example
    #     @data = @mints_user.get_variables_of_content_page_from_message_templates(2)
    def get_variables_of_content_page_from_message_templates(id)
        @client.raw("get", "/content/message-templates/content-pages/#{id}/variables")
    end

    # === Get recipient variables.
    # Get recipient variables in message templates. 
    #
    # ==== Example
    #     @data = @mints_user.get_recipient_variables
    def get_recipient_variables
        @client.raw("get", "/content/message-templates/recipient-variables")
    end
    
    # === Get driver templates.
    # Get driver templates in message templates. 
    #
    # ==== Example
    #     @data = @mints_user.get_driver_templates
    def get_driver_templates
        @client.raw("get", "/content/email-templates/driver/templates")
    end

    # === Preview message template.
    # Preview an message template based in data.
    #
    # ==== Parameters
    # data:: (Hash) -- Data to be submitted.
    #
    # ==== Example
    #     variables = {
    #       "variable_1": 1,
    #       "variable_2": "City"
    #     }
    #     data = {
    #       "body": "Message Template {{ variable_2 }}",
    #       "variables": variables.to_json
    #     }
    #     @data = @mints_user.preview_message_template(data)
    def preview_message_template(data)
        @client.raw("post", "/content/message-templates/preview", nil, data_transform(data))
    end

    # === Send Message Template.
    # Send an message template to different contacts.
    #
    # ==== Parameters
    # data:: (Hash) -- Data to be submitted.
    #
    # ==== Example
    #     data = {
    #       "contacts": [
    #         { "id": 10 }
    #       ],
    #       "emailTemplateId": 1,
    #       "resend": false
    #     }
    #     @data = @mints_user.send_message_template(data)
    def send_message_template(data)
        @client.raw("post", "/content/message-templates/send", nil, data_transform(data))
    end

    # === Duplicate Message Template.
    # Duplicate an message template.
    #
    # ==== Parameters
    # id:: (Integer) -- Message template id.
    # data:: (Hash) -- Data to be submitted.
    #
    def duplicate_message_template(id, data) #FIXME: Error in duplicating
        @client.raw("post", "/content/message-templates/#{id}/duplicate", nil, data_transform(data))
    end

    # === Get message templates.
    # Get a collection of message templates.
    #
    # ==== Parameters
    # options:: (Hash) -- List of Resource Collection Options shown above can be used as parameter.
    #
    # ==== First Example
    #     @data = @mints_user.get_message_templates
    #
    # ==== Second Example
    #     options = { "fields": "id" }
    #     @data = @mints_user.get_message_templates(options)
    def get_message_templates(options = nil)
        @client.raw("get", "/content/message-templates", options)
    end

    # === Get message template.
    # Get an message template info.
    #
    # ==== Parameters
    # id:: (Integer) -- Message template id.
    # options:: (Hash) -- List of Resource Collection Options shown above can be used as parameter.
    #
    # ==== First Example
    #     @data = @mints_user.get_message_template(1)
    #
    # ==== Second Example
    #     options = { "fields": "id" }
    #     @data = @mints_user.get_message_template(1, options)
    def get_message_template(id, options = nil)
        @client.raw("get", "/content/message-templates/#{id}", options)
    end

    # === Create message template.
    # Create an message template with data.
    #
    # ==== Parameters
    # data:: (Hash) -- Data to be submitted.
    #
    # ==== Example
    #     data = {
    #       "title": "New Message Template",
    #       "slug": "new-message-template"
    #     }
    #     @data = @mints_user.create_message_template(data)
    def create_message_template(data)
        @client.raw("post", "/content/message-templates", nil, data_transform(data))
    end

    # === Update message template.
    # Update an message template info.
    #
    # ==== Parameters
    # id:: (Integer) -- Message template id.
    # data:: (Hash) -- Data to be submitted.
    #
    # ==== Example
    #     data = {
    #       "title": "New Message Template Modified"
    #     }
    #     @data = @mints_user.update_message_template(5, data)
    def update_message_template(id, data)
        @client.raw("put", "/content/message-templates/#{id}", nil, data_transform(data))
    end

    # === Delete message template.
    # Delete an message template.
    #
    # ==== Parameters
    # id:: (Integer) -- Message template id.
    #
    # ==== Example
    #     @data = @mints_user.delete_message_template(2)
    def delete_message_template(id)
        @client.raw("delete", "/content/message-templates/#{id}")
    end
end