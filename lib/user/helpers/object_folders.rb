module ObjectFolders
    ##
    # == Object Folders
    #

    # === Get object folders.
    # Get a collection of object folders.
    #
    # ==== Parameters
    # options:: (Hash) -- List of Resource Collection Options shown above can be used as parameter.
    #
    # ==== First Example
    #     @data = @mints_user.get_object_folders
    #
    # ==== Second Example
    #     options = { "fields": "id" }
    #     @data = @mints_user.get_object_folders(options)
    def get_object_folders(options = nil)
        return @client.raw("get", "/helpers/object-folders", options)
    end

    # === Get object folder.
    # Get an object folder info.
    #
    # ==== Parameters
    # id:: (Integer) -- Object folders id.
    # options:: (Hash) -- List of Resource Collection Options shown above can be used as parameter.
    #
    # ==== First Example
    #     @data = @mints_user.get_object_folder(1)
    #
    # ==== Second Example
    #     options = { "fields": "id" }
    #     @data = @mints_user.get_object_folder(1, options)
    def get_object_folder(id, options = nil)
        return @client.raw("get", "/helpers/object-folders/#{id}", options)
    end

    # === Create object folder.
    # Create an object folder with data.
    #
    # ==== Parameters
    # data:: (Hash) -- Data to be submitted.
    #
    # ==== Example
    #     data = {
    #       "folder_id": 1,
    #       "object_id": 1
    #     }
    #     @data = @mints_user.create_object_folder(data)
    def create_object_folder(data)
        return @client.raw("post", "/helpers/object-folders", nil, data_transform(data))
    end

    # === Update object folder.
    # Update an object folder info.
    #
    # ==== Parameters
    # id:: (Integer) -- Object folder id.
    # data:: (Hash) -- Data to be submitted.
    #
    # ==== Example
    #     data = {
    #       "folder_id": 2
    #     }
    #     @data = @mints_user.update_object_folder(1, data)
    def update_object_folder(id, data)
        return @client.raw("put", "/helpers/object-folders/#{id}", nil, data_transform(data))
    end

    # === Delete object folder.
    # Delete an object folder.
    #
    # ==== Parameters
    # id:: (Integer) -- Object folder id.
    #
    # ==== Example
    #     @data = @mints_user.delete_object_folder(2)
    def delete_object_folder(id)
        return @client.raw("delete", "/helpers/object-folders/#{id}")
    end
end