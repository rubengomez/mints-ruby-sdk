# frozen_string_literal: true

module ContactAuthHelper
  ##
  # === Mints Contact Login.
  # Starts a contact session in mints.cloud and set a session cookie
  def mints_contact_login(email, password)
    # Login in mints
    response = @mints_contact.login(email, password)
    # Get session token from response
    session_token = response['session_token']
    id_token = response['contact']['contact_token'] ? response['contact']['contact_token'] : response['contact']['id_token']
    # Set a permanent cookie with the session token
    cookies.permanent[:mints_contact_session_token] = { value: session_token, secure: true, httponly: true }
    cookies.permanent[:mints_contact_id] = { value: id_token, secure: true, httponly: true }
    @contact_token = id_token
  end

  ##
  # === Mints contact Login.
  # Starts a contact session in mints.cloud and set a session cookie
  def mints_contact_magic_link_login(hash, redirect_in_error = false)
    # Login in mints
    response = @mints_contact.magic_link_login(hash)

    if response['data']
      # Get session token from response
      session_token = response['data']['session_token']
      id_token = response['data']['contact']['contact_token'] ? response['data']['contact']['contact_token'] : response['data']['contact']['id_token']
      # Set a permanent cookie with the session token
      cookies.permanent[:mints_contact_session_token] = { value: session_token, secure: true, httponly: true }
      cookies.permanent[:mints_contact_id] = { value: id_token, secure: true, httponly: true }
      @contact_token = id_token
      redirect_to response['data']['redirect_url'] || '/' if redirect_in_error
    else
      redirect_to '/' if redirect_in_error
    end
  end

  ##
  # === Mints Contact Logout.
  # Destroy session from mints.cloud and delete local session cookie
  def mints_contact_logout
    # Logout from mints
    @mints_contact.logout
    # Delete local cookie
    cookies.delete(:mints_contact_session_token)
    cookies.delete(:mints_contact_id)
    @contact_token = nil
  end

  def mints_contact_signed_in?

    begin
      # Check status in mints
      # Check status in mints
      response = @mints_contact.status
      status = response['success'] || false
    rescue => e
      # Handle the client Unauthorized error
      # if mints response is negative delete the session cookie
      cookies.delete(:mints_contact_session_token)

      status = false
    end

    status
  end
end