require_relative "./concerns/read_config_file.rb"
require_relative "../helpers/proxy_controllers_methods.rb"

module Mints
    class ContactAPIController < ActionController::API
        include AbstractController::Helpers
        include ReverseProxy::Controller
        include ReadConfigFile
        include ProxyControllersMethods

        def index
            super('contact')
        end
    end
end