# frozen_string_literal: true

module WorkflowStepObjects
  ##
  # == Workflow Step Objects
  #

  # === Get workflow step objects.
  # Get a collection of workflow step objects.
  #
  # ==== Parameters
  # options:: (Hash) -- List of Resource Collection Options shown above can be used as parameter.
  #
  # ==== First Example
  #     @data = @mints_user.get_step_objects
  #
  # ==== Second Example
  #     options = { fields: 'id' }
  #     @data = @mints_user.get_step_objects(options)
  def get_step_objects(options = nil)
    @client.raw('get', '/crm/step-objects', options)
  end

  # === Get workflow step object.
  # Get a workflow step object info.
  #
  # ==== Parameters
  # id:: (Integer) -- Workflow step object id.
  # options:: (Hash) -- List of Resource Collection Options shown above can be used as parameter.
  #
  # ==== First Example
  #     @data = @mints_user.get_step_object(1)
  #
  # ==== Second Example
  #     options = { fields: 'id, step_id' }
  #     @data = @mints_user.get_step_object(1, options)
  def get_step_object(id, options = nil)
    @client.raw('get', "/crm/step-objects/#{id}", options)
  end

  # === Create workflow step object.
  # Create a workflow step object with data.
  #
  # ==== Parameters
  # data:: (Hash) -- Data to be submitted.
  #
  # ==== Example
  #     data = {
  #       objectType: 'deals',
  #       stepId: 9,
  #       objectId: 1
  #     }
  #     @data = @mints_user.create_step_object(data)
  def create_step_object(data)
    @client.raw('post', '/crm/step-objects/', nil, data_transform(data))
  end

  # === Update workflow step object.
  # Update a workflow step object info.
  #
  # ==== Parameters
  # id:: (Integer) -- Workflow step object id.
  # data:: (Hash) -- Data to be submitted.
  #
  # ==== Example
  #     data = {
  #       stepId: 10
  #     }
  #     @data = @mints_user.update_step_object(128, data.to_json)
  def update_step_object(id, data)
    @client.raw('put', "/crm/step-objects/#{id}", nil, data)
  end

  # === Get workflow step object by object type.
  # Get a workflow step object info by an object type.
  #
  # ==== Parameters
  # object_type:: (String) -- Object type.
  # object_id:: (Integer) -- Workflow step object id.
  # options:: (Hash) -- List of Resource Collection Options shown above can be used as parameter.
  #
  # ==== First Example
  #     @data = @mints_user.get_step_object_by_object_type("deals", 1)
  #
  # ==== Second Example
  #     options = { fields: 'id, object_id' }
  #     @data = @mints_user.get_step_object_by_object_type('deals', 1, options)
  def get_step_object_by_object_type(object_type, object_id, options = nil)
    @client.raw('get', "/crm/step-objects/#{object_type}/#{object_id}", options)
  end
end
