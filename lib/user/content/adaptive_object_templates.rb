# frozen_string_literal: true

module AdaptiveObjectTemplates
  # === Get adaptive_object_templates.
  # Get a collection of adaptive_object_templates.
  #
  # ==== Parameters
  # options:: (Hash) -- List of Resource Collection Options shown above can be used as parameter.
  # use_post:: (Boolean) -- Variable to determine if the request is by 'post' or 'get' functions.
  #
  # ==== First Example
  #     @data = @mints_user.get_adaptive_object_templates
  #
  # ==== Second Example
  #     options = {
  #       fields: 'id, slug'
  #     }
  #     @data = @mints_user.get_adaptive_object_templates(options)
  #
  # ==== Third Example
  #     options = {
  #       fields: 'id, slug'
  #     }
  #     @data = @mints_user.get_adaptive_object_templates(options, true)
  def get_adaptive_object_templates(options = nil, use_post = true)
    get_query_results('/content/adaptive-object-templates', options, use_post)
  end

  # === Get adaptive_object_template.
  # Get an adaptive_object_template info.
  #
  # ==== Parameters
  # id:: (Integer) -- Adaptive object id.
  # options:: (Hash) -- List of Resource Collection Options shown above can be used as parameter.
  #
  # ==== First Example
  #     @data = @mints_user.get_adaptive_object_template(1)
  #
  # ==== Second Example
  #     options = {
  #       fields: 'id, slug'
  #     }
  #     @data = @mints_user.get_adaptive_object_template(1, options)
  def get_adaptive_object_template(id, options = nil)
    @client.raw('get', "/content/adaptive-object-templates/#{id}", options)
  end

  # === Create adaptive_object_template.
  # Create an adaptive_object_template with data.
  #
  # ==== Parameters
  # data:: (Hash) -- Data to be submitted.
  #
  # ==== Example
  #     data = {
  #       user_id: 1,
  #       slug: "new-adaptive_object_template",
  #       adaptive_object_template_template_id: 1
  #     }
  #
  #     options = { fields: 'id,slug' }
  #
  #     @data = @mints_user.create_adaptive_object_template(data, options)
  def create_adaptive_object_template(data, options = nil)
    @client.raw('post', '/content/adaptive-object-templates', options, data_transform(data))
  end

  # === Update adaptive_object_template.
  # Update an adaptive_object_template info.
  #
  # ==== Parameters
  # id:: (Integer) -- Adaptive object id.
  # data:: (Hash) -- Data to be submitted.
  #
  # ==== Example
  #     data = {
  #       user_id: 1,
  #       slug: 'new-adaptive_object_template'
  #     }
  #     @data = @mints_user.update_adaptive_object_template(5, data)
  def update_adaptive_object_template(id, data, options = nil)
    @client.raw('put', "/content/adaptive-object-templates/#{id}", options, data_transform(data))
  end

  # === Delete adaptive_object_template.
  # Delete an adaptive_object_template.
  #
  # ==== Parameters
  # id:: (Integer) -- Adaptive object id.
  #
  # ==== Example
  #     @data = @mints_user.delete_adaptive_object_template(6)
  def delete_adaptive_object_template(id)
    @client.raw('delete', "/content/adaptive-object-templates/#{id}")
  end
end
