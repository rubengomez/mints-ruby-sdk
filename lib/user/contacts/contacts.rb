# frozen_string_literal: true

module Contacts
  ##
  # == Contact Auth
  #
  # === Change password no auth.
  # Change password to an email without auth.
  #
  # ==== Parameters
  # data:: (Hash) -- Data to be submitted.
  #
  # ==== Example
  #     data = {
  #       password: '12345678',
  #       email: 'email@example.com'
  #     }
  #     @data = @mints_user.change_password_no_auth(data)
  def change_password_no_auth(data)
    @client.raw('post', '/contacts/change-password-no-auth', nil, data_transform(data))
  end
end
