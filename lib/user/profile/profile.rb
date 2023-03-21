module Profile
  ##
  # === Me.
  # Get contact logged info.
  #
  # ==== Example
  #     @data = @mints_user.me
  def me(options = nil)
    @client.raw('get', '/profile/me', options)
  end

  ##
  # == User Preferences
  #

  ##
  # === Get preferences.
  # Get preferences of current user logged.
  #
  # ==== Example
  #     @data = @mints_user.get_preferences
  def get_preferences
    @client.raw('get', '/profile/preferences')
  end

  ##
  # === Create preferences.
  # Create preferences of current user logged with data.
  #
  # ==== Parameters
  # data:: (Hash) -- Data to be submitted.
  #
  # ==== Example
  #     data = {
  #       time_zone: 'GMT-5'
  #     }
  #     @data = @mints_user.create_preferences(data)
  def create_preferences(data)
    @client.raw('post', '/profile/preferences', nil, data_transform(data))
  end

  ##
  # === Get preferences by setting key.
  # Get preferences using a setting key.
  #
  # ==== Parameters
  # setting_key:: (String) -- Setting key.
  #
  # ==== Example
  #     @data = @mints_user.get_preferences_by_setting_key('time_zone')
  def get_preferences_by_setting_key(setting_key)
    @client.raw('get', "/profile/preferences/#{setting_key}")
  end

  ##
  # == Notifications
  #

  # === Get notifications.
  # Get a collection of notifications.
  #
  # ==== Example
  #     @data = @mints_user.get_notifications
  def get_notifications(options = nil)
    @client.raw('get', '/profile/notifications', options)
  end

  # === Read notifications.
  # Read notifications by data.
  #
  # ==== Parameters
  # data:: (Hash) -- Data to be submitted.
  #
  # ==== Example
  #     data = {
  #       ids: %w[406e9b74-4a9d-42f2-afc6-1587bad6147c a2d9f582-1bdb-4e55-8af0-cd1962eaa88c],
  #       read: true
  #     }
  #     @data = @mints_user.read_notifications(data)
  def read_notifications(data)
    # TODO: Inform NotificationController.read method has been modified
    # TODO: Method in controller didnt return data
    @client.raw('post', '/profile/notifications/read', nil, data_transform(data))
  end

  # === Delete notifications.
  # Delete notifications by data.
  #
  # ==== Parameters
  # data:: (Hash) -- Data to be submitted.
  #
  # ==== Example
  #     data = {
  #       ids: ['179083e3-3678-4cf6-b75e-5a8b9761245e']
  #     }
  #     @data = @mints_user.delete_notifications(data)
  def delete_notifications(data)
    # TODO: Inform NotificationController.delete method has been modified
    # TODO: Method in controller didnt return data
    @client.raw('post', '/profile/notifications/delete', nil, data_transform(data))
  end
end
