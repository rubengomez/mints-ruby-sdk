# frozen_string_literal: true

require_relative "./read_config_file"

module MintsClients
  extend ActiveSupport::Concern

  included do
    include ReadConfigFile
    before_action :set_mints_clients
  end

  # Define the clients that will have
  # Override in the controller if you dont wanna all clients
  def define_mints_clients
    %w[contact user pub service_account]
  end

  private

  ##
  # === Set mints clients (pub, user and contact)
  # Initialize all clients from mints
  def set_mints_clients
    valid_clients = %w[contact user pub service_account]

    clients = define_mints_clients&.select { |client| valid_clients.include? client } || []

    if @debug
      puts "Clients to initialize:", clients
      puts "Host:", @host
    end

    if clients.kind_of?(Array) and @host
      clients.each do |client|
        send("set_mints_#{client}_client")
      end
    end
  end

  ##
  # === Set mints pub.
  # Initialize the public client and set the contact token
  def set_mints_pub_client
    # Initialize mints pub client, credentials taken from mints_config.yml.erb file
    visit_id = cookies[:mints_visit_id]
    contact_token_id = cookies[:mints_contact_id]

    @mints_pub = Mints::Pub.new(
      @host,
      @api_key,
      contact_token_id,
      visit_id,
      @debug
    )
  end

  ##
  # === Set mints contact client.
  # Initialize the contact client and set the contact token
  def set_mints_contact_client
    # Initialize mints contact client
    contact_session_token = cookies[:mints_contact_session_token]
    contact_token_id = cookies[:mints_contact_id]
    @mints_contact = Mints::Contact.new(
      @host,
      @api_key,
      contact_session_token,
      contact_token_id,
      @debug
    )
  end

  ##
  # === Set Mints user client.
  # Initialize the user client
  def set_mints_user_client
    # Initialize mints user client
    user_session_token = cookies[:mints_user_session_token]
    @mints_user = Mints::User.new(
      @host,
      @api_key,
      user_session_token,
      @debug
    )
  end

  ##
  # === Set Mints service account
  # Initialize the service account client
  def set_mints_service_account_client
    # Initialize service account client
    @mints_service_account = Mints::User.new(
      @host,
      @api_key,
      @api_key,
      @debug
    )
  end
end