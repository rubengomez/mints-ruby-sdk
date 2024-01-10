# frozen_string_literal: true

module AdaptiveObjects
  # === Duplicate adaptive_object.
  # Duplicate an adaptive_object.
  #
  # ==== Parameters
  # id:: (Integer) -- Adaptive object id.
  # data:: (Hash) -- Data to be submitted.
  #
  # ==== Example
  #     data = { options: [] }
  #     @data = @mints_user.duplicate_adaptive_object(1, data.to_json)
  def duplicate_adaptive_object(id, data)
    @client.raw('post', "/content/adaptive-objects/#{id}/duplicate", nil, data)
  end

  # === Get adaptive_object.
  # Get a collection of adaptive_object.
  #
  # ==== Parameters
  # options:: (Hash) -- List of Resource Collection Options shown above can be used as parameter.
  # use_post:: (Boolean) -- Variable to determine if the request is by 'post' or 'get' functions.
  #
  # ==== First Example
  #     @data = @mints_user.get_adaptive_object
  #
  # ==== Second Example
  #     options = {
  #       fields: 'id, slug'
  #     }
  #     @data = @mints_user.get_adaptive_object(options)
  #
  # ==== Third Example
  #     options = {
  #       fields: 'id, slug'
  #     }
  #     @data = @mints_user.get_adaptive_object(options, true)
  def get_adaptive_objects(options = nil, use_post = true)
    get_query_results('/content/adaptive-objects', options, use_post)
  end

  # === Get adaptive_object.
  # Get an adaptive_object info.
  #
  # ==== Parameters
  # id:: (Integer) -- Adaptive object id.
  # options:: (Hash) -- List of Resource Collection Options shown above can be used as parameter.
  #
  # ==== First Example
  #     @data = @mints_user.get_adaptive_object(1)
  #
  # ==== Second Example
  #     options = {
  #       fields: 'id, slug'
  #     }
  #     @data = @mints_user.get_adaptive_object(1, options)
  def get_adaptive_object(id, options = nil)
    @client.raw('get', "/content/adaptive-objects/#{id}", options)
  end

  # === Create adaptive_object.
  # Create an adaptive_object with data.
  #
  # ==== Parameters
  # data:: (Hash) -- Data to be submitted.
  #
  # ==== Example
  #     data = {
  #       user_id: 1,
  #       slug: "new-adaptive_object",
  #       adaptive_object_template_id: 1
  #     }
  #
  #     options = { fields: 'id,slug' }
  #
  #     @data = @mints_user.create_adaptive_object(data, options)
  def create_adaptive_object(data, options = nil)
    @client.raw('post', '/content/adaptive-objects', options, data_transform(data))
  end

  # === Update adaptive_object.
  # Update an adaptive_object info.
  #
  # ==== Parameters
  # id:: (Integer) -- Adaptive object id.
  # data:: (Hash) -- Data to be submitted.
  #
  # ==== Example
  #     data = {
  #       user_id: 1,
  #       slug: 'new-adaptive_object'
  #     }
  #     @data = @mints_user.update_adaptive_object(5, data)
  def update_adaptive_object(id, data, options = nil)
    @client.raw('put', "/content/adaptive-objects/#{id}", options, data_transform(data))
  end

  # === Delete adaptive_object.
  # Delete an adaptive_object.
  #
  # ==== Parameters
  # id:: (Integer) -- Adaptive object id.
  #
  # ==== Example
  #     @data = @mints_user.delete_adaptive_object(6)
  def delete_adaptive_object(id)
    @client.raw('delete', "/content/adaptive-objects/#{id}")
  end
end
