# frozen_string_literal: true

module Exports
  # === Get exports.
  # Get a collection of exports.
  #
  # ==== Parameters
  # options:: (Hash) -- List of Resource Collection Options shown above can be used as parameter.
  #
  # ==== First Example
  #     @data = @mints_user.get_exports
  #
  # ==== Second Example
  #     options = { sort: 'id' }
  #     @data = @mints_user.get_exports(options)
  def get_exports(options = nil)
    @client.raw('get', '/config/exports', options)
  end

  # === Get export.
  # Get an export info.
  #
  # ==== Parameters
  # id:: (Integer) -- Export id.
  #
  # ==== Example
  #     @data = @mints_user.get_export(10)
  def get_export(id)
    @client.raw('get', "/config/exports/#{id}")
  end

  # === Create export.
  # Create an export with data.
  #
  # ==== Parameters
  # data:: (Hash) -- Data to be submitted.
  #
  # ==== Example
  #     data = {
  #       title: 'New export',
  #       slug: 'new-export',
  #       object_type: 'contacts'
  #     }
  #     @data = @mints_user.create_export(data)
  def create_export(data)
    @client.raw('post', '/config/exports', nil, data_transform(data))
  end

  # === Update export.
  # Update an export info.
  #
  # ==== Parameters
  # id:: (Integer) -- Export id.
  # data:: (Hash) -- Data to be submitted.
  #
  # ==== Example
  #     data = {
  #       title: 'New export',
  #       slug: 'new-export',
  #       object_type: 'contacts'
  #     }
  #     @data = @mints_user.update_export(36, data)
  def update_export(id, data)
    @client.raw('put', "/config/exports/#{id}", nil, data_transform(data))
  end
end
