module Users
  ##
  # == Users
  #
  ##
  # === Can Users Coach.
  # Determine if users can coach.
  #
  # ==== Example
  #     @data = @mints_user.can_users_coach
  def can_users_coach
    @client.raw('get', '/config/users/can_coach')
  end

  # === Get users.
  # Get a collection of users.
  #
  # ==== Example
  #     @data = @mints_user.get_users
  def get_users(options)
    @client.raw('get', '/config/users', options)
  end

  # === Get user.
  # Get an user info.
  #
  # ==== Parameters
  # id:: (Integer) -- User id.
  #
  # ==== Example
  #     @data = @mints_user.get_user(8)
  def get_user(id)
    @client.raw('get', "/config/users/#{id}")
  end

  # === Create user.
  # Create an user with data.
  #
  # ==== Parameters
  # data:: (Hash) -- Data to be submitted.
  #
  # ==== Example
  #     data = {
  #       name: 'New User Name',
  #       email: 'new_user_email@example.com',
  #       is_confirmed: false,
  #       set_password: true,
  #       password: '123456',
  #       is_coach: false
  #     }
  #     @data = @mints_user.create_user(data)
  def create_user(data)
    @client.raw('post', '/config/users', nil, data_transform(data))
  end

  # === Update user.
  # Update an user info.
  #
  # ==== Parameters
  # id:: (Integer) -- User id.
  # data:: (Hash) -- Data to be submitted.
  #
  # ==== Example
  #     data = {
  #       name: 'New User Name Modified',
  #       email: 'new_user_name@example.com',
  #       is_active: true,
  #       is_confirmed: false,
  #       roles: ''
  #     }
  #     @data = @mints_user.update_user(14, data)
  def update_user(id, data)
    @client.raw('put', "/config/users/#{id}", nil, data_transform(data))
  end
end
