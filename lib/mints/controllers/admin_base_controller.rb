module Mints
  class AdminBaseController < ActionController::Base
    before_action :set_mints_user_client

    # def mints_user_signed_in?
    #     # Check status in mints
    #     response = @mints_user.status
    #     status = response['success'] ? response['success'] : false
    #     unless status
    #       # if mints response is negative delete the session cookie
    #       cookies.delete(:mints_user_session_token)
    #     end
    #     return status
    # end

    ##
    # === Mints user Login.
    # Starts a user session in mints.cloud and set a session cookie
    def mints_user_login(email, password)
        # Login in mints
        response = @mints_user.login(email, password)
        # Get session token from response
        session_token = response['api_token']
        # Set a permanent cookie with the session token
        cookies.permanent[:mints_user_session_token] = session_token
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
      if File.exists?("#{Rails.root}/mints_config.yml")
        config = YAML.load_file("#{Rails.root}/mints_config.yml")
        @host = config["mints"]["host"]
        @api_key = config["mints"]["api_key"]
        @debug = config["sdk"]["debug"] ? config["sdk"]["debug"] : false
      else
        raise 'MintsBadCredentialsError'
      end
      # Initialize mints user client
      @mints_user = Mints::User.new(@host, @api_key, nil, @debug)
    end
  end
end