module Importers
    ##
    # == Importers
    #

    # === Get importers results.
    # Get a results of importers.
    #
    # ==== Parameters
    # options:: (Hash) -- List of Resource Collection Options shown above can be used as parameter.
    #
    # ==== Example
    #     options = { "ip_id": 1 }
    #     @data = @mints_user.get_importers_results(options)
    def get_importers_results(options) #FIXME: Query doesnt get results. Maybe no data in db.
        @client.raw("get", "/config/importers/results", options)
    end
    
    # === Get importers configuration.
    # Get configurations of importers.
    #
    # ==== Example
    #     @data = @mints_user.get_importers_configuration
    def get_importers_configuration
        @client.raw("get", "/config/importers/configuration")
    end

    # === Get importing process status.
    # Get importing process status by importer ids.
    #
    # ==== Parameters
    # options:: (Hash) -- List of Resource Collection Options shown above can be used as parameter.
    #
    # ==== Example
    #     options = {
    #       "ids": "1,2,3"
    #     }
    #     @data = @mints_user.get_importing_process_status(options)
    def get_importing_process_status(options = nil)
        @client.raw("get", "/config/importers/importing_process_status", options)
    end

    # === Get importers attributes.
    # Get import attributes of modules in a table.
    #
    # ==== Parameters
    # options:: (Hash) -- List of Resource Collection Options shown above can be used as parameter.
    #
    # ==== Example
    #     options = {
    #       "table": "contacts",
    #       "module": "crm"
    #     }
    #     @data = @mints_user.get_importers_attributes(options)
    def get_importers_attributes(options = nil)
        @client.raw("get", "/config/importers/attributes", options)
    end

    # === Upload importer.
    # Upload to an importer.
    #
    # ==== Parameters
    # id:: (Integer) -- Importer id.
    # data:: (Hash) -- Data to be submitted.
    #
    # ==== Example
    #     data = {
    #       "csv": "archive.csv"
    #     }
    #     @data = @mints_user.upload_importer(1, data.to_json)
    def upload_importer(id, data) #TODO: Search for csv archives
        @client.raw("post", "/config/importers/#{id}/upload", nil, data)
    end

    # === Import row.
    # Import a row.
    #
    # ==== Parameters
    # data:: (Hash) -- Data to be submitted.
    #
    # ==== Example
    #     
    def import_row(data) #TODO: Research use
        @client.raw("post", "/config/importers/import_row", nil, data)
    end
    
    # === Remove importers active process.
    # Remove an active process in an importer.
    #
    # ==== Parameters
    # data:: (Hash) -- Data to be submitted.
    #
    # ==== Example
    #     
    def remove_importers_active_process(data) #FIXME: Cannot get property 'active_importing_process' of non-object. 
        @client.raw("post", "/config/importers/removeActiveProcess", nil, data_transform(data))
    end
    
    # === Get importers.
    # Get a collection of importers.
    #
    # ==== Parameters
    # options:: (Hash) -- List of Resource Collection Options shown above can be used as parameter.
    #
    # ==== First Example
    #     @data = @mints_user.get_importers
    #
    # ==== Second Example
    #     options = { "fields": "name" }
    #     @data = @mints_user.get_importers(options)
    def get_importers(options = nil)
        @client.raw("get", "/config/importers", options)
    end

    # === Get importer.
    # Get an importer info.
    #
    # ==== Parameters
    # id:: (Integer) -- Importer id.
    # options:: (Hash) -- List of Resource Collection Options shown above can be used as parameter.
    #
    # ==== First Example
    #     @data = @mints_user.get_importer(1)
    #
    # ==== Second Example
    #     options = { "fields": "name" }
    #     @data = @mints_user.get_importer(1, options)
    def get_importer(id, options = nil)
        @client.raw("get", "/config/importers/#{id}", options)
    end

    # === Create importer.
    # Create an importer with data.
    #
    # ==== Parameters
    # data:: (Hash) -- Data to be submitted.
    #
    # ==== Example
    #     data = {
    #       "name": "New Importer",
    #       "module": "crm"
    #     }
    #     @data = @mints_user.create_importer(data)
    def create_importer(data)
        @client.raw("post", "/config/importers", nil, data_transform(data))
    end

    # === Update importer.
    # Update an importer info.
    #
    # ==== Parameters
    # id:: (Integer) -- Importer id.
    # data:: (Hash) -- Data to be submitted.
    #
    # ==== Example
    #     data = {
    #       "name": "New Importer Modified"
    #     }
    #     @data = @mints_user.update_importer(4, data)
    def update_importer(id, data)
        @client.raw("put", "/config/importers/#{id}", nil, data_transform(data))
    end

    # === Delete importer.
    # Delete a importer.
    #
    # ==== Parameters
    # id:: (Integer) -- Importer id.
    #
    # ==== Example
    #     @data = @mints_user.delete_importer(4)
    def delete_importer(id)
        @client.raw("delete", "/config/importers/#{id}")
    end
    
    # === Get importers pusher key.
    # Get the pusher key of importers.
    #
    # ==== Example
    #     @data = @mints_user.get_importers_pusher_key
    def get_importers_pusher_key
        @client.raw("get", "/config/pusher_key")
    end
end