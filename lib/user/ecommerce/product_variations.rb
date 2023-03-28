# frozen_string_literal: true

module ProductVariations
  ##
  # == Product Variation
  #

  # === Generate product variation.
  # Generate a product variation.
  #
  # ==== Parameters
  # product_id:: (Integer) -- Product id.
  # data:: (Hash) -- Data to be submitted.
  #
  def generate_product_variation(product_id, data)
    # TODO: Research use
    # TODO: Notify line 247 had a '/' before Exception
    @client.raw('post', "/ecommerce/product-variations/generate/#{product_id}", nil, data_transform(data))
  end

  # === Set prices to product variations.
  # Set prices to product variations.
  #
  # ==== Parameters
  # data:: (Hash) -- Data to be submitted.
  #
  # ==== Example
  #     skus = [
  #       { id: 100 }
  #     ]
  #     prices = [
  #       { id: 1, value: 1259 },
  #       { id: 2, value: 1260 }
  #     ]
  #     data = {
  #       skus: skus,
  #       prices: prices
  #     }.to_json
  #
  #     @data = @mints_user.set_prices_to_product_variations(data)
  def set_prices_to_product_variations(data)
    @client.raw('post', '/ecommerce/product-variations/set-prices', nil, data_transform(data))
  end

  # === Get product from product variation.
  # Get a product from a product variation.
  #
  # ==== Parameters
  # product_id:: (Integer) -- Product id.
  #
  # ==== Example
  #     @data = @mints_user.get_product_from_product_variation(1)
  def get_product_from_product_variation(product_id)
    @client.raw('get', "/ecommerce/product-variations/product/#{product_id}")
  end

  # === Get product variations.
  # Get a collection of product variations.
  #
  # ==== Parameters
  # options:: (Hash) -- List of Resource Collection Options shown above can be used as parameter.
  #
  # ==== Example
  #     @data = @mints_user.get_product_variations
  def get_product_variations
    @client.raw('get', '/ecommerce/product-variations')
  end

  # === Get product variation.
  # Get a product variation info.
  #
  # ==== Parameters
  # id:: (Integer) -- Product variation id.
  #
  # ==== Example
  #     @data = @mints_user.get_product_variation(100)
  def get_product_variation(id)
    @client.raw('get', "/ecommerce/product-variations/#{id}")
  end

  # === Create product variation.
  # Create a product variation with data.
  #
  # ==== Parameters
  # data:: (Hash) -- Data to be submitted.
  #
  # ==== Example
  #     data = {
  #       title: 'New Product Variation',
  #       sku: 'NEW-PRODUCT-VARIATION-SKU',
  #       product_id: 5,
  #       supplier: 36,
  #       prices: [
  #         { id: 1, value: 300 }
  #       ]
  #     }
  #     @data = @mints_user.create_product_variation(data)
  def create_product_variation(data)
    @client.raw('post', '/ecommerce/product-variations', nil, data_transform(data))
  end

  # === Update product variation.
  # Update a product variation info.
  #
  # ==== Parameters
  # id:: (Integer) -- Product variation id.
  # data:: (Hash) -- Data to be submitted.
  #
  # ==== Example
  #     data = {
  #       title: 'New Product Variation Modified',
  #       cost: 123,
  #       prices: [
  #         { id: 1, value: 400 }
  #       ]
  #     }
  #     @data = @mints_user.update_product_variation(528, data)
  def update_product_variation(id, data)
    @client.raw('put', "/ecommerce/product-variations/#{id}", nil, data_transform(data))
  end

  # === Delete product variation.
  # Delete a product variation.
  #
  # ==== Parameters
  # id:: (Integer) -- Product variation id.
  #
  # ==== Example
  #     @data = @mints_user.delete_product_variation(528)
  def delete_product_variation(id)
    @client.raw('delete', "/ecommerce/product-variations/#{id}")
  end
end
