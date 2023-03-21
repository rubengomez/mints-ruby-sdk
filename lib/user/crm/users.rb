module Users
  ##
  # == Users
  #

  ###
  # === Get crm users.
  # Get users info in crm.
  #
  # ==== Parameters
  # options:: (Hash) -- List of Resource Collection Options shown above can be used as parameter.
  #
  # ==== First Example
  #     @data = @mints_user.get_crm_users
  #
  # ==== Second Example
  #     options = { sort: 'id', fields: 'id, email' }
  #     @data = @mints_user.get_crm_users(options)
  def get_crm_users(options = nil)
    @client.raw('get', '/crm/users', options)
  end
end
