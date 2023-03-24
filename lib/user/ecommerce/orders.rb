# frozen_string_literal: true

module Orders
  ##
  # == Orders
  #

  # === Duplicate order.
  # Duplicate an order.
  #
  # ==== Parameters
  # order_id:: (Integer) -- Order id.
  # data:: (Hash) -- Data to be submitted.
  #
  def duplicate_order(order_id, data)
    # FIXME: Doesnt read options from data and sale_price_cents column doesnt have to be null
    @client.raw('post', "/ecommerce/orders/duplicate/#{order_id}", nil, data)
  end

  # === Delete orders.
  # Delete orders.
  #
  # ==== Parameters
  # data:: (Hash) -- Data to be submitted.
  #
  # ==== Example
  #     data = { ids: [ 18 ] }
  #     @data = @mints_user.delete_orders(data)
  def delete_orders(data)
    # TODO: Inform method should return another response like 'success'
    @client.raw('delete', '/ecommerce/orders/delete', nil, data_transform(data))
  end

  # === Get orders support data.
  # Get support data used in orders.
  #
  # ==== Example
  #     @data = @mints_user.get_orders_support_data
  def get_orders_support_data
    @client.raw('get', '/ecommerce/orders/support-data')
  end

  # === Get orders.
  # Get a collection of orders.
  #
  # ==== Parameters
  # options:: (Hash) -- List of Resource Collection Options shown above can be used as parameter.
  # use_post:: (Boolean) -- Variable to determine if the request is by 'post' or 'get' functions.
  #
  # ==== First Example
  #     @data = @mints_user.get_orders
  #
  # ==== Second Example
  #     options = { fields: 'id, title' }
  #     @data = @mints_user.get_orders(options)
  #
  # ==== Third Example
  #     options = { fields: 'id, title' }
  #     @data = @mints_user.get_orders(options, false)
  def get_orders(options = nil, use_post = true)
    get_query_results('/ecommerce/orders', options, use_post)
  end

  # === Get order.
  # Get a order info.
  #
  # ==== Parameters
  # id:: (Integer) -- Order id.
  # options:: (Hash) -- List of Resource Collection Options shown above can be used as parameter.
  #
  # ==== First Example
  #     @data = @mints_user.get_order(1)
  #
  # ==== Second Example
  #     options = { fields: "title" }
  #     @data = @mints_user.get_order(1, options)
  def get_order(id, options = nil)
    @client.raw('get', "/ecommerce/orders/#{id}", options)
  end

  # === Create order.
  # Create a order with data.
  #
  # ==== Parameters
  # data:: (Hash) -- Data to be submitted.
  #
  # ==== Example
  #     data = {
  #       title: 'New Order',
  #       order_template_id: 2
  #     }
  #     @data = @mints_user.create_order(data)
  def create_order(data, options = nil)
    @client.raw('post', '/ecommerce/orders', options, data_transform(data))
  end

  # === Update order.
  # Update a order info.
  #
  # ==== Parameters
  # id:: (Integer) -- Order id.
  # data:: (Hash) -- Data to be submitted.
  #
  # ==== Example
  #     data = {
  #       title: 'New Order Modified'
  #     }
  #     @data = @mints_user.update_order(26, data)
  def update_order(id, data, options = nil)
    @client.raw('put', "/ecommerce/orders/#{id}", options, data_transform(data))
  end

  ##
  # == Order Templates
  #

  # === Get order template support data.
  # Get support data from a order template.
  #
  # ==== Parameters
  # id:: (Integer) -- Order template id.
  #
  # ==== Example
  #     @data = @mints_user.get_order_template_support_data(1)
  def get_order_template_support_data(id)
    @client.raw('get', "/ecommerce/order-templates/support-data/#{id}")
  end

  # === Get order templates.
  # Get a collection of order templates.
  #
  # ==== Parameters
  # options:: (Hash) -- List of Resource Collection Options shown above can be used as parameter.
  #
  # ==== First Example
  #     @data = @mints_user.get_order_templates
  #
  # ==== Second Example
  #     options = { fields: 'title' }
  #     @data = @mints_user.get_order_templates(options)
  def get_order_templates(options = nil)
    @client.raw('get', '/ecommerce/order-templates', options)
  end

  # === Get order template.
  # Get a order template info.
  #
  # ==== Parameters
  # id:: (Integer) -- Order template id.
  # options:: (Hash) -- List of Resource Collection Options shown above can be used as parameter.
  #
  # ==== First Example
  #     @data = @mints_user.get_order_template(1)
  #
  # ==== Second Example
  #     options = { fields: 'title' }
  #     @data = @mints_user.get_order_template(1, options)
  def get_order_template(id, options = nil)
    @client.raw('get', "/ecommerce/order-templates/#{id}", options)
  end

  # === Update order template.
  # Update a order template info.
  #
  # ==== Parameters
  # id:: (Integer) -- Order template id.
  # data:: (Hash) -- Data to be submitted.
  #
  # ==== Example
  #     data = {
  #       title: 'Inventory Increase'
  #     }
  #     @data = @mints_user.update_order_template(12, data)
  def update_order_template(id, data)
    @client.raw('put', "/ecommerce/order-templates/#{id}", nil, data_transform(data))
  end

  ##
  # == Order Items
  #

  # === Get order items support data.
  # Get support data used in order items.
  #
  # ==== Example
  #     @data = @mints_user.get_order_items_support_data
  def get_order_items_support_data
    @client.raw('get', '/ecommerce/order-items/support-data')
  end

  # TODO: The following two methods receive objects instead integer variable. Research use and test it.
  # === Detach order item from order item group.
  # Detach an order item from an order item group.
  #
  # ==== Parameters
  # order_item_id:: (Integer) -- Order item id.
  # group_id:: (Integer) -- Order items group id.
  #
  def detach_order_item_from_order_item_group(order_item_id, group_id)
    # TODO: Research use
    @client.raw('put', "/ecommerce/order-items/detach/#{order_item_id}/order-items-groups/#{group_id}")
  end

  # === Update order item from order item group.
  # Update an order item data from an order item group.
  #
  # ==== Parameters
  # order_item_id:: (Integer) -- Order item id.
  # group_id:: (Integer) -- Order items group id.
  #
  def update_order_item_from_order_item_group(order_item_id, group_id, data)
    # TODO: Research use
    url = "/ecommerce/order-items/update/#{order_item_id}/order-items-groups/#{group_id}"
    @client.raw('put', url, nil, data_transform(data))
  end

  # === Get order items.
  # Get a collection of order items.
  #
  # ==== Parameters
  # options:: (Hash) -- List of Resource Collection Options shown above can be used as parameter.
  #
  # ==== First Example
  #     @data = @mints_user.get_order_items
  #
  # ==== Second Example
  #     options = { fields: "id" }
  #     @data = @mints_user.get_order_items(options)
  def get_order_items(options = nil)
    # FIXME: CaliRouter POST method not supported.
    @client.raw('get', '/ecommerce/order-items', options)
  end

  # === Get order item.
  # Get a order item info.
  #
  # ==== Parameters
  # id:: (Integer) -- Order item id.
  # options:: (Hash) -- List of Resource Collection Options shown above can be used as parameter.
  #
  # ==== First Example
  #     @data = @mints_user.get_order_item(1)
  #
  # ==== Second Example
  #     options = { fields: 'id' }
  #     @data = @mints_user.get_order_item(1, options)
  def get_order_item(id, options = nil)
    @client.raw('get', "/ecommerce/order-items/#{id}", options)
  end

  # === Update order item.
  # Update a order item info.
  #
  # ==== Parameters
  # id:: (Integer) -- Order item id.
  # data:: (Hash) -- Data to be submitted.
  #
  # ==== Example
  #     data = { title: 'No title in order items' }
  #     @data = @mints_user.update_order_item(1, data)
  def update_order_item(id, data)
    # TODO: Research what can update
    @client.raw('put', "/ecommerce/order-items/#{id}", nil, data_transform(data))
  end
end
