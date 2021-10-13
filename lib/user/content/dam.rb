module DAM
    ##
    # == dam
    #

    # === Get dam loadtree.
    # Get dam loadtree.
    #
    # ==== Example
    #     @data = @mints_user.get_dam_loadtree
    def get_dam_loadtree
        return @client.raw("get", "/content/dam/loadtree")
    end

    # === Get dam asset locations.
    # Get an asset locations in dam.
    #
    # ==== Parameters
    # options:: (Hash) -- List of Resource Collection Options shown above can be used as parameter.
    #
    # ==== Example
    #     @data = @mints_user.get_dam_asset_locations(options)
    def get_dam_asset_locations(options)
        return @client.raw("get", "/content/dam/asset-locations", options)
    end
    
    def paste_dam(data) #FIXME: Controller detect object array like a single array.
        return @client.raw("post", "/content/dam/paste", nil, data)
    end

    # === Rename dam.
    # Rename folder or asset in dam.
    #
    # ==== Parameters
    # data:: (Hash) -- Data to be submited.
    #
    # ==== Example
    #     data = {
    #       "itemType": "asset",
    #       "id": 21,
    #       "title": "accusantium",
    #       "description": "Ea cupiditate",
    #       "slug": "accusantium"
    #     }
    #     @data = @mints_user.rename_dam(data.to_json)
    def rename_dam(data)
        return @client.raw("post", "/content/dam/rename", nil, data)
    end

    # === Search dam.
    # Search folder or asset in dam.
    #
    # ==== Parameters
    # data:: (Hash) -- Data to be submited.
    #
    # ==== Example
    #     data = {
    #       "searchFor": "accusantium"
    #     }
    #     @data = @mints_user.search_dam(data.to_json)
    def search_dam(data)
        return @client.raw("post", "/content/dam/search", nil, data)
    end

    def send_to_trash_dam(data) #FIXME: Invalid argument supplied for foreach()
        return @client.raw("post", "/content/dam/sendToTrash", nil, data)
    end

    def delete_dam(data) #FIXME: Invalid argument supplied for foreach()
        return @client.raw("post", "/content/dam/delete", nil, data)
    end

    # === Create dam folder.
    # Create a folder in dam.
    #
    # ==== Parameters
    # data:: (Hash) -- Data to be submited.
    #
    # ==== Example
    #     data = {
    #       "folder_name": "New Dam Folder",
    #       "slug": "new-dam-folder"
    #     }
    #     @data = @mints_user.create_dam_folder(data.to_json)
    def create_dam_folder(data)
        return @client.raw("post", "/content/folders/create", nil, data)
    end
end