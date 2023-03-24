# frozen_string_literal: true

require_relative './concerns/mints_clients'
require_relative '../helpers/user_auth_helper'

module Mints
  class AdminBaseController < ActionController::Base

    include MintsClients
    include UserAuthHelper

    # Override default values for mints clients concern
    def define_mints_clients
      %w[user service_account]
    end
  end
end