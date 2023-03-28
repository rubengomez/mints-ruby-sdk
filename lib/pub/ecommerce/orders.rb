# frozen_string_literal: true

module Orders
  ##
  # === Get My Shopping Cart.
  # Get a collection of items in the shopping cart.
  #
  # ==== Example
  #     @data = @mints_ pub.get_my_shopping_cart
  def get_my_shopping_cart(options = nil)
    @client.raw('get', '/ecommerce/my-shopping-cart', options, nil)
  end

  ##
  # === Add Item To Shopping Cart.
  # Add an item into a shopping cart.
  #
  # ==== Parameters
  # data:: (Hash) -- Data to be submitted.
  #
  # ==== Example
  #     data = {
  #       quantity: 1,
  #       sku_id: 1,
  #       price_list_id: 1
  #     }
  #     @data = @mints_ pub.add_item_to_shopping_cart(data)
  def add_item_to_shopping_cart(data, options = nil)
    @client.raw('post', '/ecommerce/shopping-cart', options, data_transform(data))
  end
end
