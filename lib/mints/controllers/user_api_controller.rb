require 'reverse_proxy/controller'
require 'reverse_proxy/client'
module Mints
    class UserAPIController < ActionController::API
        include AbstractController::Helpers
        include ActionController::Cookies
        include ReverseProxy::Controller
        before_action :set_config_variables
        
        def index
            headers = {
                'host' => "#{@host.gsub('http://', '').gsub('https://', '')}",
                'ApiKey' => "#{@api_key}", 
                'Content-Type'=> 'application/json', 
                'Accept'=> 'application/json'
            }
            if cookies[:mints_contact_session_token]
                session_token = cookies[:mints_user_session_token]
                headers["Authorization"] = "Bearer #{session_token}"
            end            
            reverse_proxy "#{@host}", headers: headers, verify_ssl: false do |config|
                # Request failed!
                config.on_missing do |code, response|
                    # We got a 404!
                    if code == 404
                        raise ActionController::RoutingError.new('Not Found')
                    end
                end
            end
        end    

        private

        def set_config_variables
            if File.exists?("#{Rails.root}/mints_config.yml")
                config = YAML.load_file("#{Rails.root}/mints_config.yml")
                @host = config["mints"]["host"]
                @api_key = config["mints"]["api_key"]
            end
        end
    end
end