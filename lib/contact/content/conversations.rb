# frozen_string_literal: true

module ContactConversations
  ##
  # === Get Conversations.
  # Get a collection of conversations.
  #
  # ==== Parameters
  # options:: (Hash) -- List of Resource Collection Options shown above can be used as parameter.
  # FIXME: This method doesn't return data.
  def get_conversations(options = nil)
    @client.raw('get', '/content/conversations', options, nil, @contact_v1_url)
  end

  ##
  # === Get Conversation.
  # Get a conversation info.
  #
  # ==== Parameters
  # id:: (Integer) -- Conversation id.
  # options:: (Hash) -- List of Resource Collection Options shown above can be used as parameter.
  # FIXME: This method doesn't return data.
  def get_conversation(id, options = nil)
    @client.raw('get', "/content/conversations/#{id}", options, nil, @contact_v1_url)
  end

  ##
  # === Create Conversation.
  # Create a conversation with data.
  #
  # ==== Parameters
  # data:: (Hash) -- Data to be submitted.
  #
  # ==== Example
  #     data = {
  #       title: 'New Conversation To Test'
  #     }
  #     @data = @mints_contact.create_conversation(data)
  def create_conversation(data)
    @client.raw('post', '/content/conversations', nil, data_transform(data), @contact_v1_url)
  end

  ##
  # === Update Conversation.
  # Update a location template info.
  #
  # ==== Parameters
  # id:: (Integer) -- Conversation id.
  # data:: (Hash) -- Data to be submitted.
  # FIXME: This method doesn't locate conversation id to be updated.
  def update_conversation(id, data)
    @client.raw('put', "/content/conversations/#{id}", nil, data_transform(data), @contact_v1_url)
  end

  ##
  # === Update Conversation Status.
  # Update a conversation status.
  #
  # ==== Parameters
  # id:: (Integer) -- Conversation id.
  # data:: (Hash) -- Data to be submitted.
  # FIXME: This method doesn't locate conversation id to be updated.
  def update_conversation_status(id, data)
    @client.raw('put', "/content/conversations/#{id}/status", nil, data_transform(data), @contact_v1_url)
  end

  ##
  # === Get Conversation Participants.
  # Get a conversation participants.
  #
  # ==== Parameters
  # id:: (Integer) -- Conversation id.
  # FIXME: This method doesn't locate conversation id to be updated.
  def get_conversation_participants(id)
    #TODO: Test if this method needs data in options.
    @client.raw('get', "/content/conversations/#{id}/participants", nil, nil, @contact_v1_url)
  end

  ##
  # === Get Messages.
  # Get a collection of messages.
  #
  # ==== Parameters
  # options:: (Hash) -- List of Resource Collection Options shown above can be used as parameter.
  # FIXME: This method doesn't return data.
  def get_messages(options = nil)
    @client.raw('get', '/content/messages', options, nil, @contact_v1_url)
  end

  ##
  # === Get Message.
  # Get a message info.
  #
  # ==== Parameters
  # id:: (Integer) -- Message id.
  # options:: (Hash) -- List of Resource Collection Options shown above can be used as parameter.
  # FIXME: This method doesn't return data.
  def get_message(id, options = nil)
    @client.raw('get', "/content/messages/#{id}", options, nil, @contact_v1_url)
  end

  ##
  # === Create Message.
  # Create a message with data.
  #
  # ==== Parameters
  # data:: (Hash) -- Data to be submitted.
  #
  # ==== Example
  #     data = {
  #       conversation_id: 3,
  #       type: 'text',
  #       value: {
  #         text: 'Message Text'
  #       }
  #     }
  #     @data = @mints_contact.create_message(data)
  def create_message(data)
    @client.raw('post', '/content/messages', nil, data_transform(data), @contact_v1_url)
  end
end
