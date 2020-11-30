module Mints
  class BaseController < ActionController::Base
    before_action :set_contact_token
    before_action :set_mints_pub_client
    before_action :register_visit
    before_action :set_mints_contact_client

    def mints_contact_signed_in?
        # Check status in mints
        response = @mints_contact.status
        status = response['success'] ? response['success'] : false
        unless status
          # if mints response is negative delete the session cookie
          cookies.delete(:mints_contact_session_token)
        end
        return status
    end

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
    
    private

    ##
    # === Register visit.
    # Call register visit method from the public client and set/renew the cookie mints_contact_id
    def register_visit
      response = @mints_pub.register_visit(request)
      @contact_token = response['user_token']
      @visit_id = response['visit_id']
      cookies.permanent[:mints_contact_id] = @contact_token
    end

    ##
    # === Set mints pub.
    # Initialize the public client and set the contact token
    def set_mints_pub_client
      if File.exists?("#{Rails.root}/mints_config.yml.erb")
        template = ERB.new File.new("#{Rails.root}/mints_config.yml.erb").read
        config = YAML.load template.result(binding)
        @host = config["mints"]["host"]
        @api_key = config["mints"]["api_key"]
        @debug = config["sdk"]["debug"] ? config["sdk"]["debug"] : false
      else
        raise 'MintsBadCredentialsError'
      end
      # Initialize mints pub client, credentials taken from mints_config.yml.erb file
      @mints_pub = Mints::Pub.new(@host, @api_key, nil, @debug)
      # Set contact token from cookie
      @mints_pub.client.session_token = @contact_token
    end

    ##
    # === Set contact token.
    # Set contact token variable from the mints_contact_id cookie value
    def set_contact_token
      @contact_token = cookies[:mints_contact_id]
    end

    ##
    # === Set mints contact client.
    # Initialize the public client and set the contact token
    def set_mints_contact_client
      # Initialize mints clontact client
      @mints_contact = Mints::Contact.new(@host, @api_key, nil, @debug)
    end
  end
end