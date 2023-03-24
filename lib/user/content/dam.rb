# frozen_string_literal: true

module DAM
  ##
  # == dam
  #

  # === Get dam load_tree.
  # Get dam load_tree.
  #
  # ==== Example
  #     @data = @mints_user.get_dam_load_tree
  def get_dam_load_tree
    @client.raw('get', '/content/dam/loadtree')
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
    @client.raw('get', '/content/dam/asset-locations', options)
  end

  def paste_dam(data)
    # FIXME: Controller detect object array like a single array.
    @client.raw('post', '/content/dam/paste', nil, data)
  end

  # === Rename dam.
  # Rename folder or asset in dam.
  #
  # ==== Parameters
  # data:: (Hash) -- Data to be submitted.
  #
  # ==== Example
  #     data = {
  #       itemType: 'asset',
  #       id: 21,
  #       title: 'New folder title',
  #       description: 'New folder description',
  #       slug: 'new-folder-title'
  #     }
  #     @data = @mints_user.rename_dam(data.to_json)
  def rename_dam(data)
    @client.raw('post', '/content/dam/rename', nil, data)
  end

  # === Search dam.
  # Search folder or asset in dam.
  #
  # ==== Parameters
  # data:: (Hash) -- Data to be submitted.
  #
  # ==== Example
  #     data = {
  #       searchFor: 'Folder name'
  #     }
  #     @data = @mints_user.search_dam(data.to_json)
  def search_dam(data)
    @client.raw('post', '/content/dam/search', nil, data)
  end

  def send_to_trash_dam(data)
    # FIXME: Invalid argument supplied for foreach()
    @client.raw('post', '/content/dam/sendToTrash', nil, data)
  end

  def delete_dam(data)
    # FIXME: Invalid argument supplied for foreach()
    @client.raw('post', '/content/dam/delete', nil, data)
  end

  # === Create dam folder.
  # Create a folder in dam.
  #
  # ==== Parameters
  # data:: (Hash) -- Data to be submitted.
  #
  # ==== Example
  #     data = {
  #       folder_name: 'New Dam Folder',
  #       slug: 'new-dam-folder'
  #     }
  #     @data = @mints_user.create_dam_folder(data.to_json)
  def create_dam_folder(data)
    @client.raw('post', '/content/folders/create', nil, data)
  end
end
