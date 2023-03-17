require_relative "./concerns/read_config_file.rb"
require_relative "../helpers/proxy_controllers_methods.rb"

module Mints
    class PublicAPIController < ActionController::API
        include ReverseProxy::Controller
        include AbstractController::Helpers
        include ReadConfigFile
        include ProxyControllersMethods

    end
end