require_relative "./client.rb"
include ActionController::Cookies
module Mints
  class Contact
    attr_reader :client
    ##
    # === Initialize.
    # Class constructor
    #
    def initialize(host, api_key, session_token = nil, contact_token_id = nil, debug = false)
      @client = Mints::Client.new(host, api_key, "contact", session_token, contact_token_id, debug)
    end

    ##
    # === Login.
    # Starts a contact session
    #
    def login(email, password)
      data = {
        email: email,
        password: password
      }
      response = @client.raw("post", "/contacts/login", nil, {data: data})
      if response.key? "session_token"
        @client.session_token = response["session_token"]
      end
      return response
    end

    ##
    # === Magic Link Login.
    # Starts a contact session
    #
    def magic_link_login(token)
      response = @client.raw("get", "/contacts/magic-link-login/#{token}", nil, '/api/v1')
      if response.key? "session_token"
        @client.session_token = response["session_token"]
      end
      return response
    end

    ##
    # === Send magic link to contact
    def send_magic_link(email, template_slug, redirectUrl = '', lifeTime = 1440, maxVisits = nil)
      data = {
        email: email,
        lifeTime: lifeTime,
        maxVisits: maxVisits,
        redirectUrl: redirectUrl,
        templateId: template_slug
      }
      response = @client.raw("post", "/contacts/magic-link", nil, { data: data }, '/api/v1')
      return response
    end

    ##
    # === Logout.
    # Ends a contact session
    #
    def logout
      response = @client.raw("post", "/contacts/logout") if session_token?
      if response["success"]
        @client.session_token = nil
      end 
      return response
    end

    ##
    # === Change Password.
    # Change password
    #
    def change_password(data)
      return @client.raw("post", "/contacts/change-password", nil, data)
    end

    ##
    # === Recover Password.
    # Recover password
    #
    def recover_password(data)
      return @client.raw("post", "/contacts/recover-password", nil, data)
    end

    ##
    # === Reset Password.
    # Reset password
    #
    def reset_password(data)
      return @client.raw("post", "/contacts/reset-password", nil, data)
    end

    ##
    # === OAuth Login.
    # Login a contact using oauth
    #
    def oauth_login(data)
      return @client.raw("post", "/contacts/oauth-login", nil, data)
    end

    ##
    # === Me.
    # Get contact logged info
    #
    def me
      return @client.raw("get", "/contacts/me")
    end

    ##
    # === Status.
    # Get contact logged status
    #
    def status
      return @client.raw("get", "/contacts/status")
    end

    ##
    # === Update.
    # Update logged contact attributes
    #
    def update(data)
      return @client.raw("put", "/contacts/update", nil, data)
    end

    private

    def session_token?
      if @client.session_token
        return true
      else
        raise "Unauthenticated"
        return false
      end
    end
  end
end
