module Workflows
    ##
    # == Workflows
    #

    # === Get workflows.
    # Get a collection of workflows.
    #
    # ==== Parameters
    # options:: (Hash) -- List of Resource Collection Options shown above can be used as parameter.
    #
    # ==== First Example
    #     @data = @mints_user.get_workflows
    #
    # ==== Second Example
    #     options = { "sort": "title", "fields": "title" }
    #     @data = @mints_user.get_workflows(options)
    def get_workflows(options = nil)
        @client.raw("get", "/crm/workflows", options)
    end

    # === Get workflow.
    # Get a workflow.
    #
    # ==== Parameters
    # id:: (Integer) -- Workflow id.
    # options:: (Hash) -- List of Resource Collection Options shown above can be used as parameter.
    #
    # ==== First Example
    #     @data = @mints_user.get_workflow(1)
    #
    # ==== Second Example
    #     options = { "fields": "id, title" }
    #     @data = @mints_user.get_workflow(1, options)
    def get_workflow(id, options = nil)
        @client.raw("get", "/crm/workflows/#{id}", options)
    end

    # === Create workflow.
    # Create a workflow with data.
    #
    # ==== Parameters
    # data:: (Hash) -- Data to be submitted.
    #
    # ==== Example
    #     data = {
    #       "title": "New Workflow",
    #       "object_type": "deals"
    #     }
    #     @data = @mints_user.create_workflow(data.to_json)
    def create_workflow(data)
        @client.raw("post", "/crm/workflows/", nil, data)
    end

    # === Update workflow.
    # Update a workflow info.
    #
    # ==== Parameters
    # id:: (Integer) -- Workflow id.
    # data:: (Hash) -- Data to be submitted.
    #
    # ==== Example
    #     data = {
    #       "title": "New Workflow Modified"
    #     }
    #     @data = @mints_user.update_workflow(7, data)
    def update_workflow(id, data)
        @client.raw("put", "/crm/workflows/#{id}", nil, correct_json(data))
    end
end