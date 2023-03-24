# frozen_string_literal: true

module UserAuthHelper

  def mints_user_signed_in?
    begin
      # Check status in mints
      response = @mints_user.me['data']
    rescue => e
      # Handle the client Unauthorized error
      # if mints response is negative delete the session cookie
      cookies.delete(:mints_user_session_token)
      response = nil
    end

    response
  end

  ##
  # === Mints user Login.
  # Starts a user session in mints.cloud and set a session cookie
  def mints_user_login(email, password)
    # Login in mints
    response = @mints_user.login(email, password)
    # Get session token from response
    session_token = response['api_token']
    # Set a permanent cookie with the session token
    cookies[:mints_user_session_token] = { value: session_token, secure: true, httponly: true, expires: 1.day }
  end

  ##
  # === Mints user Login.
  # Starts a user session in mints.cloud and set a session cookie
  def mints_user_magic_link_login(hash)
    # Login in mints
    response = @mints_user.magic_link_login(hash)
    if response['data']
      # Set a cookie with the session token
      cookies[:mints_user_session_token] = { value: response['data']['api_token'], secure: true, httponly: true, expires: 1.day }
      redirect_to response['data']['redirect_url'] || '/'
    else
      redirect_to '/'
    end
  end

  ##
  # === Mints user Logout.
  # Destroy session from mints.cloud and delete local session cookie
  def mints_user_logout
    # Logout from mints
    # @mints_user.logout
    # Delete local cookie
    cookies.delete(:mints_user_session_token)
  end
end
