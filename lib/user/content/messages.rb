module Messages
    ##
    # == Messages
    #
    
    ###
    # === Get messages.
    # Get a collection of messages.
    #
    # ==== Parameters
    # options:: (Hash) -- List of Resource Collection Options shown above can be used as parameter.
    #
    # ==== First Example
    #     @data = @mints_user.get_messages
    #
    # ==== Second Example
    #     options = { "fields": "value" }
    #     @data = @mints_user.get_messages(options)
    def get_messages(options = nil)
        return @client.raw("get", "/content/messages", options)
    end

    # === Get message.
    # Get a message info.
    #
    # ==== Parameters
    # id:: (Integer) -- Message id.
    # options:: (Hash) -- List of Resource Collection Options shown above can be used as parameter.
    #
    # ==== First Example
    #     @data = @mints_user.get_message(1)
    #
    # ==== Second Example
    #     options = { "fields": "value" }
    #     @data = @mints_user.get_message(1, options)
    def get_message(id, options = nil)
        return @client.raw("get", "/content/messages/#{id}", options)
    end

    # === Create message.
    # Create a message with data.
    #
    # ==== Parameters
    # data:: (Hash) -- Data to be submitted.
    #
    # ==== Example
    #     data = {
    #       "type": "text",
    #       "conversation_id": 1,
    #       "sender_type": "User",
    #       "sender_id": 1,
    #       "value": {
    #         "text": "Hello"
    #       }
    #     }
    #     @data = @mints_user.create_message(data)
    def create_message(data)
        return @client.raw("post", "/content/messages", nil, data_transform(data))
    end
    
    # === Update message.
    # Update a message info.
    #
    # ==== Parameters
    # id:: (Integer) -- Message id.
    # data:: (Hash) -- Data to be submitted.
    #
    # ==== Example
    #     data = {
    #       "value": {
    #         "text": "Hello World!"
    #       }
    #     }
    #     @data = @mints_user.update_message(102, data)
    def update_message(id, data)
        return @client.raw("put", "/content/messages/#{id}", nil, data_transform(data))
    end
    
    # === Delete message.
    # Delete a message.
    #
    # ==== Parameters
    # id:: (Integer) -- Message id.
    #
    # ==== Example
    #     @data = @mints_user.delete_message(101)
    def delete_message(id)
        return @client.raw("delete", "/content/messages/#{id}")
    end
end