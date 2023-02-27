require_relative "./concerns/read_config_file.rb"
require_relative "../helpers/proxy_controllers_methods.rb"

module Mints
    class UserAPIController < ActionController::API
        include AbstractController::Helpers
        include ReadConfigFile
        include ProxyControllersMethods

        def index
            super('user')
        end
    end
end