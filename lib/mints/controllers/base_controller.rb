require_relative "./concerns/mints_clients.rb"
require_relative "../helpers/contact_auth_helper.rb"

module Mints
  class BaseController < ActionController::Base
    # Concerns
    include MintsClients

    # Helpers
    include ContactAuthHelper

    before_action :register_visit

    # Override default values for mints clients concern
    def define_mints_clients
      %w[ contact pub ]
    end

    private

    ##
    # === Register visit.
    # Call register visit method from the public client and set/renew the cookie mints_contact_id
    def register_visit
      if @debug
        puts "REQUEST IN REGISTER VISIT: #{request}"
        puts "BODY REQUEST: #{request.body}"
        puts "AUTH REQUEST: #{request.authorization}"
        puts "LENGTH REQUEST: #{request.content_length}"
        puts "FORM DATA REQUEST: #{request.form_data?}"
        puts "FULLPATH REQUEST: #{request.fullpath}"
        puts "HEADERS REQUEST: #{request.headers}"
        puts "IP REQUEST: #{request.ip}"
        puts "REQUEST IP ADDRESS: #{request['ip_address']}"
        puts "REQUEST REMOTE IP: #{request['remote_ip']}"
      end

      response = @mints_pub.register_visit(request)

      puts "RESPONSE IN REGISTER VISIT: #{response}" if @debug

      @contact_token = response['contact_token'] || response['user_token']
      @visit_id = response['visit_id']

      puts "VISIT ID: #{@visit_id}" if @debug

      cookies.permanent[:mints_contact_id] = { value: @contact_token, secure: true, httponly: true }
      cookies.permanent[:mints_visit_id] = { value: @visit_id, secure: true, httponly: true }
    end

  end
end