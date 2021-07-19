module Mints
  class BaseApiController < ActionController::Base
    before_action :set_mints_clients

    ##
    # === Mints Contact Login.
    # Starts a contact session in mints.cloud and set a session cookie
    def mints_contact_login(email, password)
        # Login in mints
        response = @mints_contact.login(email, password)
        # Get session token from response
        session_token = response['session_token']
        id_token = response['contact']['id_token']
        # Set a permanent cookie with the session token
        cookies.permanent[:mints_contact_session_token] = session_token
        cookies.permanent[:mints_contact_id] = id_token
        @contact_token = id_token
      end
      
    ##
    # === Mints cotnact Login.
    # Starts a cotnact session in mints.cloud and set a session cookie
    def mints_contact_magic_link_login(hash)
      # Login in mints
      response = @mints_contact.magic_link_login(hash)
      if response['data']
        # Get session token from response
        session_token = response['data']['session_token']
        id_token = response['data']['contact']['id_token']
        # Set a permanent cookie with the session token
        cookies.permanent[:mints_contact_session_token] = session_token
        cookies.permanent[:mints_contact_id] = id_token
        @contact_token = id_token
        redirect_to response['data']['redirect_url'] ? response['data']['redirect_url'] : '/'
      else
        redirect_to '/'
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
    # === Mints user Login.
    # Starts a user session in mints.cloud and set a session cookie
    def mints_user_magic_link_login(hash)
      # Login in mints
      response = @mints_user.magic_link_login(hash)
      if response['data']
        # Set a cookie with the session token
        cookies[:mints_user_session_token] = { value: response['data']['api_token'], expires: 1.day }
        redirect_to response['data']['redirect_url'] ? response['data']['redirect_url'] : '/'
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
    # === Set mints clients (pub, user and contact)
    # Initialize all clients from mitns
    def set_mints_clients
      if File.exists?("#{Rails.root}/mints_config.yml.erb")
        template = ERB.new File.new("#{Rails.root}/mints_config.yml.erb").read
        config = YAML.load template.result(binding)
        @host = config["mints"]["host"]
        @api_key = config["mints"]["api_key"]
        @debug = config["sdk"]["debug"] ? config["sdk"]["debug"] : false

        #public client
        set_mints_pub_client
        #contact client
        set_mints_contact_client
        #user client
        set_mints_user_client
      else
        raise 'MintsBadCredentialsError'
      end
    end

    ##
    # === Set mints pub.
    # Initialize the public client and set the contact token
    def set_mints_pub_client
      
      # Initialize mints pub client, credentials taken from mints_config.yml.erb file
      @mints_pub = Mints::Pub.new(@host, @api_key, nil, @debug)
      # Set contact token from cookie
      @mints_pub.client.session_token = @contact_token
    end

    ##
    # === Set mints contact client.
    # Initialize the public client and set the contact token
    def set_mints_contact_client
      # Initialize mints clontact client
      session_token = cookies[:mints_contact_session_token] ? cookies[:mints_contact_session_token] : nil
      contact_token_id = cookies[:mints_contact_id] ? cookies[:mints_contact_id] : nil
      @mints_contact = Mints::Contact.new(@host, @api_key, session_token, contact_token_id, @debug)
    end
    
    ##
    # === Set Mints user client.
    # Initialize the public client and set the user token
    def set_mints_user_client
      # Initialize mints user client
      session_token = cookies[:mints_user_session_token] ? cookies[:mints_user_session_token] : nil
      @mints_user = Mints::User.new(@host, @api_key, session_token, @debug)
    end
  end
end