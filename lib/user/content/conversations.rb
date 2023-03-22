module Conversations
  ##
  # == Conversations
  #

  ###
  # === Get conversations.
  # Get a collection of conversations.
  #
  # ==== Parameters
  # options:: (Hash) -- List of Resource Collection Options shown above can be used as parameter.
  #
  # ==== First Example
  #     @data = @mints_user.get_conversations
  #
  # ==== Second Example
  #     options = { fields: 'title' }
  #     @data = @mints_user.get_conversations(options)
  def get_conversations(options = nil)
    @client.raw('get', '/content/conversations', options)
  end

  # === Get conversation.
  # Get a conversation info.
  #
  # ==== Parameters
  # id:: (Integer) -- Conversation id.
  # options:: (Hash) -- List of Resource Collection Options shown above can be used as parameter.
  #
  # ==== First Example
  #     @data = @mints_user.get_conversation(1)
  #
  # ==== Second Example
  #     options = { fields: 'title' }
  #     @data = @mints_user.get_conversation(1, options)
  def get_conversation(id, options = nil)
    @client.raw('get', "/content/conversations/#{id}", options)
  end

  # === Create conversation.
  # Create a conversation with data.
  #
  # ==== Parameters
  # data:: (Hash) -- Data to be submitted.
  #
  # ==== Example
  #     data = {
  #       title: 'New Conversation'
  #     }
  #     @data = @mints_user.create_conversation(data)
  def create_conversation(data, options = nil)
    @client.raw('post', '/content/conversations', options, data_transform(data))
  end

  # === Update conversation.
  # Update a conversation info.
  #
  # ==== Parameters
  # id:: (Integer) -- Conversation id.
  # data:: (Hash) -- Data to be submitted.
  #
  # ==== Example
  #     data = {
  #       title: 'New Conversation Modified'
  #     }
  #     @data = @mints_user.update_conversation(13, data)
  def update_conversation(id, data, options = nil)
    @client.raw('put', "/content/conversations/#{id}", options, data_transform(data))
  end

  # === Delete conversation.
  # Delete a conversation.
  #
  # ==== Parameters
  # id:: (Integer) -- Conversation id.
  #
  # ==== Example
  #     @data = @mints_user.delete_conversation(11)
  def delete_conversation(id)
    @client.raw('delete', "/content/conversations/#{id}")
  end

  # === Update conversation status.
  # Update a conversation status.
  #
  # ==== Parameters
  # id:: (Integer) -- Conversation id.
  # data:: (Hash) -- Data to be submitted.
  #
  # ==== Example
  #     data = {
  #       status: 'read'
  #     }
  #     @data = @mints_user.update_conversation_status(13, data)
  def update_conversation_status(id, data)
    @client.raw('put', "/content/conversations/#{id}/status", nil, data_transform(data))
  end

  # === Get conversation participants.
  # Get participants in a conversation.
  #
  # ==== Parameters
  # id:: (Integer) -- Conversation id.
  #
  # ==== Example
  #     @data = @mints_user.get_conversation_participants(1)
  def get_conversation_participants(id)
    @client.raw('get', "/content/conversations/#{id}/participants")
  end

  # === Attach user in conversation.
  # Attach an user in a conversation.
  #
  # ==== Parameters
  # id:: (Integer) -- Conversation id.
  # data:: (Hash) -- Data to be submitted.
  #
  # ==== Example
  #     data = {
  #       user_id: 2
  #     }
  #     @data = @mints_user.attach_user_in_conversation(13, data)
  def attach_user_in_conversation(id, data)
    @client.raw('post', "/content/conversations/#{id}/attach-user", nil, data_transform(data))
  end

  # === Detach user in conversation.
  # Detach an user in a conversation.
  #
  # ==== Parameters
  # id:: (Integer) -- Conversation id.
  # data:: (Hash) -- Data to be submitted.
  #
  # ==== Example
  #     data = {
  #       user_id: 2
  #     }
  #     @data = @mints_user.detach_user_in_conversation(13, data)
  def detach_user_in_conversation(id, data)
    @client.raw('post', "/content/conversations/#{id}/detach-user", nil, data_transform(data))
  end

  # === Attach contact in conversation.
  # Attach a contact in a conversation.
  #
  # ==== Parameters
  # id:: (Integer) -- Conversation id.
  # data:: (Hash) -- Data to be submitted.
  #
  # ==== Example
  #     data = {
  #       contact_id: 2
  #     }
  #     @data = @mints_user.attach_contact_in_conversation(1, data)
  def attach_contact_in_conversation(id, data)
    @client.raw('post', "/content/conversations/#{id}/attach-contact", nil, data_transform(data))
  end

  # === Detach contact in conversation.
  # Detach a contact in a conversation.
  #
  # ==== Parameters
  # id:: (Integer) -- Contact id.
  # data:: (Hash) -- Data to be submitted.
  #
  # ==== Example
  #     data = {
  #       contact_id: 2
  #     }
  #     @data = @mints_user.detach_contact_in_conversation(1, data)
  def detach_contact_in_conversation(id, data)
    @client.raw('post', "/content/conversations/#{id}/detach-contact", nil, data_transform(data))
  end

  # === Attach form in conversation.
  # Attach a form in a conversation.
  #
  # ==== Parameters
  # id:: (Integer) -- Conversation id.
  # data:: (Hash) -- Data to be submitted.
  #
  # ==== Example
  #     data = {
  #       form_id: 2
  #     }
  #     @data = @mints_user.attach_form_in_conversation(1, data)
  def attach_form_in_conversation(id, data)
    @client.raw('post', "/content/conversations/#{id}/attach-form", nil, data_transform(data))
  end

  # === Detach form in conversation.
  # Detach a form in a conversation.
  #
  # ==== Parameters
  # id:: (Integer) -- Contact id.
  # data:: (Hash) -- Data to be submitted.
  #
  # ==== Example
  #     data = {
  #       form_id: 2
  #     }
  #     @data = @mints_user.detach_form_in_conversation(1, data)
  def detach_form_in_conversation(id, data)
    @client.raw('post', "/content/conversations/#{id}/detach-form", nil, data_transform(data))
  end
end
