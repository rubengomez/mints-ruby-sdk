module PublicFolders
    ##
    # == Public Folders
    #

    # === Sync public folders for object.
    # Sync public folders for object.
    #
    # ==== Parameters
    # data:: (Hash) -- Data to be submitted.
    #
    # ==== Example
    #     data = {
    #       "object_type": "contacts",
    #       "object_id": 1
    #     }
    #     @data = @mints_user.sync_public_folders_for_object(data.to_json)
    def sync_public_folders_for_object(data)
        @client.raw('put', "/config/public-folders/sync_public-folders_for_object", nil, data)
    end
    
    # === Get public folders for object.
    # Get public folders for object.
    #
    # ==== Parameters
    # options:: (Hash) -- List of Resource Collection Options shown above can be used as parameter.
    #
    # ==== Example
    #     options = {
    #       "object_type": "contacts",
    #       "object_id": 1
    #     }
    #     @data = @mints_user.get_public_folders_for_object(options)
    def get_public_folders_for_object(options)
        @client.raw('get', "/config/public-folders/get_public-folders_for_object", options)
    end

    # === Get public folders.
    # Get a collection of public folders.
    #
    # ==== Example
    #     @data = @mints_user.get_public_folders
    def get_public_folders(options = nil)
        @client.raw('get', "/config/public-folders", options)
    end
    
    # === Create public folder.
    # Create a public folder with data.
    #
    # ==== Parameters
    # data:: (Hash) -- Data to be submitted.
    #
    # ==== Example
    #     data = {
    #       title: "New Public Folder",
    #       slug: "new-public-folder",
    #       "object_type": "contacts",
    #       "visible": true
    #     }
    #     @data = @mints_user.create_public_folder(data.to_json)
    def create_public_folder(data)
        @client.raw('post', "/config/public-folders", nil, data)
    end

    # === Update public folder.
    # Update a public folder info.
    #
    # ==== Parameters
    # id:: (Integer) -- Public folder id.
    # data:: (Hash) -- Data to be submitted.
    #
    # ==== Example
    #     data = {
    #       title: "New Public Folder Modified",
    #       slug: "new-public-folder",
    #       "object_type": "contacts",
    #       "visible": true
    #     }
    #     @data = @mints_user.update_public_folder(20, data.to_json)
    def update_public_folder(id, data)
        @client.raw('put', "/config/public-folders/#{id}", nil, data)
    end
    
    # === Get public folder support data.
    # Get support data used in a public folder.
    #
    # ==== Parameters
    # id:: (Integer) -- Public folder id.
    #
    # ==== Example
    #     @data = @mints_user.get_public_folder_support_data(1)
    def get_public_folder_support_data(id)
        @client.raw('get', "/config/public-folders/support-data/#{id}")
    end
    
    # === Get public folder.
    # Get a public folder info.
    #
    # ==== Parameters
    # id:: (Integer) -- Public folder id.
    # options:: (Hash) -- List of Resource Collection Options shown above can be used as parameter.
    #
    # ==== Example
    #      @data = @mints_user.get_public_folder(3)
    def get_public_folder(id)
        @client.raw('get', "/config/public-folders/#{id}")
    end
end