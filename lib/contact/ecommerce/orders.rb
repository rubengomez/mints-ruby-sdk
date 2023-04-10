# frozen_string_literal: true

module Orders
  ##
  # === Get Orders.
  # Get a collection of orders.
  #
  # ==== Parameters
  # options:: (Hash) -- List of Resource Collection Options shown above can be used as parameter.
  # use_post:: (Boolean) -- Variable to determine if the request is by 'post' or 'get' functions.
  #
  # ==== First Example
  #     @data = @mints_pub.get_orders
  #
  # ==== Second Example
  #     options = { fields: 'title' }
  #     @data = @mints_pub.get_orders(options)
  #
  # ==== Third Example
  #     options = { fields: 'title' }
  #     @data = @mints_pub.get_orders(options, false)
  def get_orders(options = nil, use_post = true)
    if use_post
      @client.raw('post', '/ecommerce/orders/query', options, nil, @contact_v1_url)
    else
      @client.raw('get', '/ecommerce/orders', options, nil, @contact_v1_url)
    end
  end

  ##
  # === Get Order.
  # Get an order info.
  #
  # ==== Parameters
  # id:: (Integer) -- Order id.
  # options:: (Hash) -- List of Resource Collection Options shown above can be used as parameter.
  #
  # ==== First Example
  #     @data = @mints_pub.get_product(25)
  #
  # ==== Second Example
  #     options = {
  #       fields: 'title'
  #     }
  #     @data = @mints_pub.get_product(25, options)
  def get_order(id, options = nil)
    @client.raw('get', "/ecommerce/orders/#{id}", options, nil, @contact_v1_url)
  end

  ##
  # === Create Order.
  # Create a order with data.
  #
  # ==== Parameters
  # data:: (Hash) -- Data to be submitted.
  #
  # ==== Example
  #     data = {
  #       order_template_id: 1,
  #       order_status_id: 1,
  #       sales_channel_id: 1
  #     }
  #     @data = @mints_pub.create_order(data)
  def create_order(data)
    @client.raw('post', '/ecommerce/orders', nil, data_transform(data), @contact_v1_url)
  end

  ##
  # === Update Order.
  # Update an order info.
  #
  # ==== Parameters
  # id:: (Integer) -- Order Id
  # data:: (Hash) -- Data to be submitted.
  # FIXME: This method doesnt update an order.
  def update_order(id, data)
    @client.raw('put', "/ecommerce/orders/#{id}", nil, data_transform(data), @contact_v1_url)
  end

  # TODO: No tested
  # === Detach Order Item From Order Item Group.
  # Detach an order item from an order item group.
  #
  # ==== Parameters
  # orderI_iemI_i:: (Integer) -- Order item id.
  # group_id:: (Integer) -- Order items group id.
  #
  def detach_order_item_from_order_item_group(order_item_id, group_id)
    @client.raw('put', "/ecommerce/order-items/detach/#{order_item_id}/order-items-groups/#{group_id}", nil, nil, @contact_v1_url)
  end

  #TODO: No tested
  # === Update Order Item From Order Item Group.
  # Update an order item data from an order item group.
  #
  # ==== Parameters
  # orderI_iemI_i:: (Integer) -- Order item id.
  # group_id:: (Integer) -- Order items group id.
  #
  def update_order_item_from_order_item_group(order_item_id, group_id, data)
    url = "/ecommerce/order-items/update/#{order_item_id}/order-items-groups/#{group_id}"
    @client.raw('put', url, nil, data_transform(data), @contact_v1_url)
  end

  ##
  # === Get My Shopping Cart.
  # Get a collection of items in the shopping cart.
  #
  # ==== Example
  #     @data = @mints_contact.get_my_shopping_cart
  def get_my_shopping_cart(options = nil)
    @client.raw('get', '/ecommerce/my-shopping-cart', options, nil, @contact_v1_url)
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
  #     @data = @mints_contact.add_item_to_shopping_cart(data)
  def add_item_to_shopping_cart(data, options = nil)
    @client.raw('post', '/ecommerce/shopping-cart', options, data_transform(data), @contact_v1_url)
  end
end
