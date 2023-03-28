# frozen_string_literal: true

module VariantOptions
  ##
  # == Variant Options
  #

  # === Get variant options.
  # Get a collection of variant options.
  #
  # ==== Parameters
  # options:: (Hash) -- List of Resource Collection Options shown above can be used as parameter.
  #
  # ==== First Example
  #     @data = @mints_user.get_variant_options
  #
  # ==== Second Example
  #     options = { fields: 'id, title' }
  #     @data = @mints_user.get_variant_options(options)
  def get_variant_options(options = nil)
    @client.raw('get', '/ecommerce/variant-options', options)
  end

  # === Get variant option.
  # Get a variant options info.
  #
  # ==== Parameters
  # id:: (Integer) -- Variant option id.
  # options:: (Hash) -- List of Resource Collection Options shown above can be used as parameter.
  #
  # ==== First Example
  #     @data = @mints_user.get_variant_option(1)
  #
  # ==== Second Example
  #     options = { fields: 'id, title' }
  #     @data = @mints_user.get_variant_option(1, options)
  def get_variant_option(id, options = nil)
    @client.raw('get', "/ecommerce/variant-options/#{id}", options)
  end

  # === Create variant option.
  # Create a variant option with data.
  #
  # ==== Parameters
  # data:: (Hash) -- Data to be submitted.
  #
  # ==== Example
  #     data = {
  #       title: 'New Variant Option'
  #     }
  #     @data = @mints_user.create_variant_option(data)
  def create_variant_option(data)
    @client.raw('post', '/ecommerce/variant-options', nil, data_transform(data))
  end

  # === Update variant option.
  # Update a variant option info.
  #
  # ==== Parameters
  # id:: (Integer) -- Variant option id.
  # data:: (Hash) -- Data to be submitted.
  #
  # ==== Example
  #     data = {
  #       title: 'New Variant Option Modified'
  #     }
  #     @data = @mints_user.update_variant_option(6, data)
  def update_variant_option(id, data)
    @client.raw('put', "/ecommerce/variant-options/#{id}", nil, data_transform(data))
  end
end
