# frozen_string_literal: true

module ConversationTemplates
  ##
  # == Conversation templates
  #

  ###
  # === Get conversation templates.
  # Get a collection of conversation templates.
  #
  # ==== Parameters
  # options:: (Hash) -- List of Resource Collection Options shown above can be used as parameter.
  #
  # ==== First Example
  #     @data = @mints_user.get_conversations
  #
  # ==== Second Example
  #     options = { fields: 'title' }
  #     @data = @mints_user.get_conversation_templates(options)
  def get_conversation_templates(options = nil)
    @client.raw('get', '/content/conversation-templates', options)
  end

  # === Get conversation template.
  # Get a conversation template info.
  #
  # ==== Parameters
  # id:: (Integer) -- Conversation id.
  # options:: (Hash) -- List of Resource Collection Options shown above can be used as parameter.
  #
  # ==== First Example
  #     @data = @mints_user.get_conversation_template(1)
  #
  # ==== Second Example
  #     options = { fields: 'title' }
  #     @data = @mints_user.get_conversation_template(1, options)
  def get_conversation_template(id, options = nil)
    @client.raw('get', "/content/conversation-templates/#{id}", options)
  end

  # === Create conversation template.
  # Create a conversation template with data.
  #
  # ==== Parameters
  # data:: (Hash) -- Data to be submitted.
  #
  # ==== Example
  #     data = {
  #       title: 'New Conversation Template',
  #       slug: 'new-conversation-template'
  #     }
  #     @data = @mints_user.create_conversation_template(data)
  def create_conversation_template(data, options = nil)
    @client.raw('post', '/content/conversation-templates', options, data_transform(data))
  end

  # === Update conversation template.
  # Update a conversation template info.
  #
  # ==== Parameters
  # id:: (Integer) -- Conversation template id.
  # data:: (Hash) -- Data to be submitted.
  #
  # ==== Example
  #     data = {
  #       title: 'Conversation Template'
  #       slug: 'conversation-template'
  #     }
  #     @data = @mints_user.update_conversation_template(13, data)
  def update_conversation_template(id, data, options = nil)
    @client.raw('put', "/content/conversation-templates/#{id}", options, data_transform(data))
  end

  # === Delete conversation template.
  # Delete a conversation template.
  #
  # ==== Parameters
  # id:: (Integer) -- Conversation template id.
  #
  # ==== Example
  #     @data = @mints_user.delete_conversation_template(11)
  def delete_conversation_template(id)
    @client.raw('delete', "/content/conversation-templates/#{id}")
  end

  # === Duplicate conversation template.
  # Duplicate a conversation template.
  #
  # ==== Parameters
  # id:: (Integer) -- Conversation template id.
  # data:: (Hash) -- Data to be submitted.
  #
  # ==== Example
  #     data = {
  #       title: 'Duplicated conversation template'
  #     }
  #     @data = @mints_user.duplicate_conversation_template(13, data)
  def duplicate_conversation_template(id, data)
    @client.raw('put', "/content/conversation-templates/#{id}/duplicate", nil, data_transform(data))
  end

  # === Update activation words.
  # Update activation words in a conversation template.
  #
  # ==== Parameters
  # conversation_template_id:: (Integer) -- Conversation template id.
  # data:: (Hash) -- Data to be submitted.
  #
  # ==== Example
  #     data = {
  #       activationWords: %w[ hello world ],
  #       formId: 1
  #     }
  #     @data = @mints_user.attach_user_in_conversation(13, data)
  def update_activation_words(conversation_template_id, data)
    url = "/content/conversation-templates/#{conversation_template_id}/activation-words"
    @client.raw('post', url, nil, data_transform(data))
  end

  # === Attach form in conversation template.
  # Attach a form in the conversation template.
  #
  # ==== Parameters
  # id:: (Integer) -- Conversation template id.
  # data:: (Hash) -- Data to be submitted.
  #
  # ==== Example
  #     data = {
  #       form_id: 2
  #     }
  #     @data = @mints_user.attach_form_in_conversation_template(13, data)
  def attach_form_in_conversation_template(id, data)
    @client.raw('post', "/content/conversation-templates/#{id}/attach-form", nil, data_transform(data))
  end

  # === Detach form in conversation template.
  # Detach a form in a conversation template.
  #
  # ==== Parameters
  # id:: (Integer) -- Conversation template id.
  #
  # ==== Example
  #     @data = @mints_user.detach_form_in_conversation_template(conversation_id, form_id)
  def detach_form_in_conversation_template(id, form_id)
    @client.raw('delete', "/content/conversation-templates/#{id}/detach-form/#{form_id}")
  end
end
