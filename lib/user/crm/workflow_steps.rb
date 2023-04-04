# frozen_string_literal: true

module WorkFlowSteps
  ##
  # == Workflow Steps
  #

  # === Create workflow step.
  # Create a workflow step with data.
  #
  # ==== Parameters
  # data:: (Hash) -- Data to be submitted.
  #
  # ==== Example
  #     data = {
  #       stepTitle: 'Step Title',
  #       workflowId: 1
  #     }
  #     @data = @mints_user.create_workflow_step(data.to_json)
  def create_workflow_step(data, options = nil)
    @client.raw('post', '/crm/steps', options, data)
  end

  # === Update workflow step.
  # Update a workflow step info.
  #
  # ==== Parameters
  # id:: (Integer) -- Workflow step id.
  # data:: (Hash) -- Data to be submitted.
  #
  # ==== Example
  #     data = {
  #       stepTitle: 'Step Title Modified'
  #     }
  #     @data = @mints_user.update_workflow_step(23, data)
  def update_workflow_step(id, data, options = nil)
    @client.raw('put', "/crm/steps/#{id}", options, data)
  end

  # === Delete workflow step.
  # Delete a workflow step.
  #
  # ==== Parameters
  # id:: (Integer) -- Workflow step id.
  #
  # ==== Example
  #     @data = @mints_user.delete_workflow_step(51)
  def delete_workflow_step(id)
    @client.raw('delete', "/crm/steps/#{id}")
  end
end
