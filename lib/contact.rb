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
    # ==== Parameters:
    # * +email+ - [_String_] The email that will be logged.
    # * +password+ - [_String_] The password of the email.
    #
    # ==== Example
    #     @mints_contact.login("brown.abigail@dubuque.com", "helloword")
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
    # Starts a contact session with a token received in the contact email. The token will be received by send_magic_link method.
    #
    # ==== Parameters:
    # * +token+ - [_String_] The email that will be logged.
    #
    # ==== Example
    #     @mints_contact.magic_link_login(
    #       "d8618c6d-a165-41cb-b3ec-d053cbf30059:zm54HtRdfHED8dpILZpjyqjPIceiaXNLfOklqM92fveBS0nDtyPYBlI4CPlPe3zq"
    #     )
    #
    def magic_link_login(token)
      response = @client.raw("get", "/contacts/magic-link-login/#{token}", nil, '/api/v1')
      if response.key? "session_token"
        @client.session_token = response["session_token"]
      end
      return response
    end

    ##
    # === Send Magic Link
    # Send magic link to contact by email. That magic link will be used in magic_link_login method.
    #
    # ==== Parameters:
    # * +email+ - [_String_] Contact's email.
    # * +template_slug+ - [_String_] Email template's slug to be used in the email.
    # * +redirectUrl+ - [_String_] Url to be redirected in the implemented page.
    # * +lifeTime+ - [_Integer_] Maximum time of use in minutes.
    # * +maxVisits+ - [_Integer_] The maximum number of uses of a token. 
    #
    # ==== First Example
    #     @mints_contact.send_magic_link("brown.abigail@dubuque.com", "")
    #
    # ==== Second Example
    #     @mints_contact.send_magic_link("brown.abigail@dubuque.com", "", "", 1440, 3)
    #
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
    # Ends a contact session previously logged.
    #
    # ==== Example
    #     @mints_contact.login('brown.abigail@dubuque.com', 'helloword')
    #     @mints_contact.logout
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
    # Change password without email. To change the password a contact must be logged.
    #
    # ==== Parameters:
    # * +data+ - [] A new password allocated in a data key.
    #
    # ==== Example
    #     @mints_contact.login('brown.abigail@dubuque.com', 'helloword')
    #     data = { "data": { "password": "123456" } }
    #     @mints_contact.change_password(data)
    #
    def change_password(data)
      return @client.raw("post", "/contacts/change-password", nil, data)
    end

    ##
    # === Recover Password.
    # Send a email that contains a token to a contact. That token will be used in reset_password to establish a new password. 
    #
    # ==== Parameters:
    # * +data+ - [] It's a data key where will be hosted the destination email. 
    #
    # ==== Example
    #     data = { "data": { "email": "brown.abigail@dubuque.com" } }
    #     @mints_contact.recover_password(data)
    #
    def recover_password(data)
      return @client.raw("post", "/contacts/recover-password", nil, data)
    end

    ##
    # === Reset Password.
    # Reset password using a token. The token is obtained by recover_password method.
    #
    # ==== Parameters:
    # * +data+ - [] It's a set of data which contains all the information to reset a contact password.
    #
    # ==== Example
    #     data = { "data": { 
    #       "email": "brown.abigail@dubuque.com", 
    #       "password": "helloword", 
    #       "password_confirmation": "helloword", 
    #       "token": "644aa3aa0831d782cc42e42b11aedea9a2234389af4f429a8d96651295ecfa09" 
    #     } }
    #     @mints_contact.reset_password(data)
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
    # Get contact logged info.
    #
    # ==== Example
    #     @mints_contact.me
    #
    def me
      return @client.raw("get", "/contacts/me")
    end

    ##
    # === Status.
    # Get contact logged status.
    #
    # ==== Example
    #     @mints_contact.status
    #
    def status
      return @client.raw("get", "/contacts/status")
    end

    ##
    # === Update.
    # Update logged contact attributes.
    #
    # ==== Parameters:
    # * +data+ - [] It's the data to update with a session active.
    #
    # ==== Example
    #     @mints_contact.login("brown.abigail@dubuque.com", "helloword")
    #     data = { "data": { 
    #       "given_name": "Alonso", 
    #       "last_name": "Garcia"
    #     } }
    #     @mints_contact.update(data)
    #
    def update(data)
      return @client.raw("put", "/contacts/update", nil, data)
    end

    ##
    # === Register.
    # Register a contact.
    #
    # ==== Parameters:
    # * +data+ - [] It's the register data.
    #
    # ==== Example
    #     data = { "data": {
    #       "email": "carlos@mints.cloud",
    #       "given_name": "Carlos",
    #       "last_name": "Fernandez",
    #       "password": "123456"
    #     } }
    #     @mints_contact.register(data);
    #
    def register(data)
      return @client.raw("post", "/contacts/register", nil, data)
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
