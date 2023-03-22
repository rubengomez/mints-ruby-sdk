module UserFolders
  ##
  # == User Folders
  #

  # === Get user folders.
  # Get a collection of user folders.
  #
  # ==== Parameters
  # options:: (Hash) -- List of Resource Collection Options shown above can be used as parameter.
  #
  # ==== First Example
  #     @data = @mints_user.get_user_folders
  #
  # ==== Second Example
  #     options = { fields: 'folder' }
  #     @data = @mints_user.get_user_folders(options)
  def get_user_folders(options = nil)
    @client.raw('get', '/helpers/folders', options)
  end

  # === Get user folder.
  # Get an user folder info.
  #
  # ==== Parameters
  # id:: (Integer) -- User folder id.
  # options:: (Hash) -- List of Resource Collection Options shown above can be used as parameter.
  #
  # ==== First Example
  #     @data = @mints_user.get_user_folder(1)
  #
  # ==== Second Example
  #     options = { fields: 'user_id, folder' }
  #     @data = @mints_user.get_user_folder(1, options)
  def get_user_folder(id, options = nil)
    @client.raw('get', "/helpers/folders/#{id}", options)
  end

  # === Create user folder.
  # Create an user folder with data.
  #
  # ==== Parameters
  # data:: (Hash) -- Data to be submitted.
  #
  # ==== Example
  #     data = {
  #       folder: 'new-user-folder',
  #       object_type: 'contacts'
  #     }
  #     @data = @mints_user.create_user_folder(data)
  def create_user_folder(data)
    @client.raw('post', '/helpers/folders', nil, data_transform(data))
  end

  # === Update user folder.
  # Update an user folder info.
  #
  # ==== Parameters
  # id:: (Integer) -- User folder id.
  # data:: (Hash) -- Data to be submitted.
  #
  # ==== Example
  #     data = {
  #       folder:'new-user-folder-modifier',
  #       object_type:'contact'
  #     }
  #     @data = @mints_user.update_user_folder(289, data)
  def update_user_folder(id, data)
    @client.raw('put', "/helpers/folders/#{id}", nil, data_transform(data))
  end

  # === Delete user folder.
  # Delete an user folder.
  #
  # ==== Parameters
  # id:: (Integer) -- User folder id.
  #
  # ==== Example
  #     @data = @mints_user.delete_user_folder(289)
  def delete_user_folder(id)
    @client.raw('delete', "/helpers/folders/#{id}")
  end
end
