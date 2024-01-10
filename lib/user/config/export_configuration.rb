# frozen_string_literal: true

module ExportConfiguration
  # === Get export_configurations.
  # Get a collection of export_configurations.
  #
  # ==== Parameters
  # options:: (Hash) -- List of Resource Collection Options shown above can be used as parameter.
  #
  # ==== First Example
  #     @data = @mints_user.get_export_configurations
  #
  # ==== Second Example
  #     options = { sort: 'id' }
  #     @data = @mints_user.get_export_configurations(options)
  def get_export_configurations(options = nil)
    @client.raw('get', '/config/export-configurations', options)
  end

  # === Get export.
  # Get an export configuration info.
  #
  # ==== Parameters
  # id:: (Integer) -- Export configuration id.
  #
  # ==== Example
  #     @data = @mints_user.get_export(10)
  def get_export_configuration(id)
    @client.raw('get', "/config/export-configurations/#{id}")
  end

  # === Create export.
  # Create an export with data.
  #
  # ==== Parameters
  # data:: (Hash) -- Data to be submitted.
  #
  # ==== Example
  #     data = {
  #       title: 'New configuration',
  #       slug: 'new-configuration',
  #       object_model: 'Contact',
  #       config_json: {}
  #     }
  #     @data = @mints_user.create_export(data)
  def create_export_configuration(data)
    @client.raw('post', '/config/export-configurations', nil, data_transform(data))
  end

  # === Update export configuration.
  # Update an export configuration info.
  #
  # ==== Parameters
  # id:: (Integer) -- Export configuration id.
  # data:: (Hash) -- Data to be submitted.
  #
  # ==== Example
  #     data = {
  #       title: 'New configuration',
  #       slug: 'new-configuration',
  #       object_model: 'Contact',
  #       config_json: {}
  #     }
  #     @data = @mints_user.update_export(36, data)
  def update_export_configuration(id, data)
    @client.raw('put', "/config/export-configurations/#{id}", nil, data_transform(data))
  end
end
