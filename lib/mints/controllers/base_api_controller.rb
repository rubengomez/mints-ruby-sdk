# frozen_string_literal: true

require_relative './concerns/mints_clients'
require_relative '../helpers/user_auth_helper'
require_relative '../helpers/contact_auth_helper'

module Mints
  class BaseApiController < ActionController::Base
    # Concerns
    include MintsClients

    # Helpers
    include ContactAuthHelper
    include UserAuthHelper

    def define_mints_clients
      %w[contact pub]
    end

    ##
    # === Mints contact Login.
    # This method works to override the base to add the redirect parameter
    # The main method is located in contact_auth_helper.rb
    def mints_contact_magic_link_login(hash)
      super(hash, true)
    end
  end
end