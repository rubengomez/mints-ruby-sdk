require_relative "./client.rb"
module Mints
  class Contact
    attr_reader :client
    def initialize(host, api_key, session_token = nil)      
      @client = Mints::Client.new(host, api_key, "contact", session_token)
    end

    def register(given_name, last_name, email, password)
      data = {
        given_name: given_name,
        last_name: last_name,
        email: email,
        password: password
      }
      return @client.raw("post", "/contacts/register", nil, {data: data})
    end

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

    def logout
      response = @client.raw("post", "/contacts/logout") if session_token?
      if response["success"]
        @client.session_token = nil
      end
      return response
    end

    def change_password(data)
      return @client.raw("post", "/contacts/change-password", nil, data)
    end

    def recover_password(data)
      return @client.raw("post", "/contacts/recover-password", nil, data)
    end

    def reset_password(data)
      return @client.raw("post", "/contacts/reset-password", nil, data)
    end

    def auth_login(data)
      return @client.raw("post", "/contacts/oauth-login", nil, data)
    end

    def me
      return @client.raw("get", "/contacts/me")
    end

    def status
      return @client.raw("get", "/contacts/status")
    end

    def update
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
