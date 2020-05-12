module Mints
  class BaseController < ActionController::Base
    before_action :set_contact_token
    before_action :set_mints_pub
    before_action :register_visit
    
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
    def set_mints_pub
      # Initialize mints pub client, credentials taken from mints_config.yml file
      @mints_pub = Mints::Pub.new
      # Set contact token from cookie
      @mints_pub.client.session_token = @contact_token
    end

    ##
    # === Set contact token.
    # Set contact token variable from the mints_contact_id cookie value
    def set_contact_token
        @contact_token = cookies[:mints_contact_id]
    end
  end
end