module Mints
  class AdminBaseController < ActionController::Base
    before_action :set_mints_user_client

    def mints_user_signed_in?
        # Check status in mints
        response = @mints_user.me
        status = response['data'] ? true : false
        unless status
          # if mints response is negative delete the session cookie
          #cookies.delete(:mints_user_session_token)
        end
        return status
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
      if response['data'] && response['data']['redirect_url']
        # Set a cookie with the session token
        cookies[:mints_user_session_token] = { value: response['data']['api_token'], expires: 1.day, secure: true, httponly: true }
        redirect_to response['data']['redirect_url']
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
    
    private

    ##
    # === Set Mints user client.
    # Initialize the public client and set the user token
    def set_mints_user_client
      if File.exists?("#{Rails.root}/mints_config.yml.erb")
        template = ERB.new File.new("#{Rails.root}/mints_config.yml.erb").read
        config = YAML.load template.result(binding)
        @host = config["mints"]["host"]
        @api_key = config["mints"]["api_key"]
        @debug = config["sdk"]["debug"] ? config["sdk"]["debug"] : false
      else
        raise 'MintsBadCredentialsError'
      end
      # Initialize mints user client
      session_token = cookies[:mints_user_session_token] ? cookies[:mints_user_session_token] : nil
      @mints_user = Mints::User.new(@host, @api_key, session_token, @debug)
    end
  end
end