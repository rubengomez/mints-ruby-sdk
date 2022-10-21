module Marketing
    ##
    # == Automation
    #

    # === Get automations.
    # Get a collection of automations.
    #
    # ==== Parameters
    # options:: (Hash) -- List of Resource Collection Options shown above can be used as parameter.
    #
    # ==== First Example
    #     @data = @mints_user.get_automations
    #
    # ==== Second Example
    #       options = {
    #         "fields": "title"
    #       }
    #       @data = @mints_user.get_automations(options)
    def get_automations(options = nil)
        return @client.raw("get", "/marketing/automation", options)
    end

    # === Get automation.
    # Get an automation info.
    #
    # ==== Parameters
    # id:: (Integer) -- Automation id.
    # options:: (Hash) -- List of Resource Collection Options shown above can be used as parameter.
    #
    # ==== First Example
    #     @data = @mints_user.get_automation(1)
    #
    # ==== Second Example
    #     options = {
    #       "fields": "title, id"
    #     }
    #     @data = @mints_user.get_automation(1, options)
    def get_automation(id, options = nil)
        return @client.raw("get", "/marketing/automation/#{id}", options)
    end

    # === Create automation.
    # Create an automation with data.
    #
    # ==== Parameters
    # data:: (Hash) -- Data to be submitted.
    #
    # ==== Example
    #     data = {
    #       "title": "New Automation"
    #     }
    #     @data = @mints_user.create_automation(data)
    def create_automation(data)
        return @client.raw("post", "/marketing/automation/", nil, data_transform(data))
    end

    # === Update automation.
    # Update an automation info.
    #
    # ==== Parameters
    # id:: (Integer) -- Automation id.
    # data:: (Hash) -- Data to be submitted.
    #
    def update_automation(id, data) #FIXME: Method doesn't work.
        return @client.raw("put", "/marketing/automation/#{id}", nil, data_transform(data))
    end

    # === Delete automation.
    # Delete an automation.
    #
    # ==== Parameters
    # id:: (Integer) -- Automation id.
    #
    # ==== Example
    #     @data = @mints_user.delete_automation(5)
    def delete_automation(id)
        return @client.raw("delete", "/marketing/automation/#{id}")
    end

    # === Get automation executions.
    # Get executions of an automation.
    #
    # ==== Parameters
    # id:: (Integer) -- Automation id.
    #
    # ==== Example
    #     @data = @mints_user.get_automation_executions(1)
    def get_automation_executions(id)
        return @client.raw("get", "/marketing/automation/#{id}/executions")
    end
    
    # === Reset automation.
    # Reset an automation.
    #
    # ==== Parameters
    # id:: (Integer) -- Automation id.
    #
    # ==== Example
    #     @data = @mints_user.reset_automation(1)
    def reset_automation(id)
        return @client.raw("post", "/marketing/automation/#{id}/reset")
    end
    
    # === Duplicate automation.
    # Duplicate an automation.
    #
    # ==== Parameters
    # id:: (Integer) -- Automation id.
    # data:: (Hash) -- Data to be submitted.
    #
    # ==== Example
    #     data = {
    #       "options": [] 
    #     }
    #     @data = @mints_user.duplicate_automation(1, data.to_json)
    def duplicate_automation(id, data)
        return @client.raw("post", "/marketing/automation/#{id}/duplicate", nil, data)
    end
end