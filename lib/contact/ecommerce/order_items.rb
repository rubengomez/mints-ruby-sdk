# frozen_string_literal: true

module OrderItems
  ##
  # === Get Order Items.
  # Get a collection of order items.
  #TODO: Find a way to show order items.
  def get_order_items(options = nil)
    @client.raw('get', '/ecommerce/order-items', options, nil, @contact_v1_url)
  end

  ##
  # === Get Order Item.
  # Get an order item info.
  # TODO: Find a way to show order items.
  def get_order_item(id, options = nil)
    @client.raw('get', "/ecommerce/order-items/#{id}", options, nil, @contact_v1_url)
  end
end
