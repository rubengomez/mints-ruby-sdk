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
            
            url_need_cache = false
            result_from_cache = false
            time = 0
            full_url = request.original_url

            if request.method == "GET"
                if url_need_cache
                    @redis_config['groups'].each do |group|
                        group['urls'].each do |url|
                            if full_url.match url
                                time = group['time']
                                url_need_cache = true
                                break
                            end
                        end
                        break if url_need_cache  
                    end
                end
            end

            if url_need_cache
                if @redis_server.get(full_url)
                    response = @redis_server.get(full_url)
                    result_from_cache = true
                    render json: response
                else
                    reverse_proxy "#{@host}", headers: headers, verify_ssl: false do |config|
                        # Request succeded!
                        config.on_response do |code, response|
                            @redis_server.setex(full_url,time,response.body)
                        end
                        # Request failed!
                        config.on_missing do |code, response|
                            # We got a 404!
                            if code == 404
                                raise ActionController::RoutingError.new('Not Found')
                            end
                        end
                    end
                end
            else
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
        end    

        private

        def set_config_variables
            if File.exists?("#{Rails.root}/mints_config.yml")
                config = YAML.load_file("#{Rails.root}/mints_config.yml")
                @host = config["mints"]["host"]
                @api_key = config["mints"]["api_key"]
                @redis_server = Redis.new(host: config['redis_cache']['redis_host'])
                @redis_config = config['redis_cache']
                @use_cache = config['redis_cache']['use_cache'] if config['redis_cache']['use_cache']
            end
        end
    end
end