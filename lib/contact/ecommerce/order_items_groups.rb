# frozen_string_literal: true

module ContactOrderItemsGroups
  ##
  # === Get Order Item Groups.
  # Get a collection of order item groups.
  #
  # ==== Parameters
  # options:: (Hash) -- List of Resource Collection Options shown above can be used as parameter.
  #
  # ==== First Example
  #     @data = @mints_contact.get_order_item_groups
  #
  # ==== Second Example
  #     options = {
  #       fields: 'id'
  #     }
  #     @data = @mints_contact.get_order_item_groups(options)
  def get_order_item_groups(options = nil)
    @client.raw('get', '/ecommerce/order-items-groups', options, nil, @contact_v1_url)
  end

  ##
  # === Get Order Item Group.
  # Get an order item group info.
  #
  # ==== Parameters
  # id:: (Integer) -- Order Item Group Id.
  # options:: (Hash) -- List of Resource Collection Options shown above can be used as parameter.
  #
  # ==== First Example
  #     @data = @mints_contact.get_order_item_group(130)
  #
  # ==== Second Example
  #     options = {
  #       fields: 'id'
  #     }
  #     @data = @mints_contact.get_order_item_group(130, options)
  def get_order_item_group(id, options = nil)
    @client.raw('get', "/ecommerce/order-items-groups/#{id}", options, nil, @contact_v1_url)
  end

  ##
  # === Create Order Item Group.
  # Create an order item group with data if you are related to that order.
  #
  # ==== Parameters
  # data:: (Hash) -- Data to be submitted.
  #
  # ==== First Example
  #     data = {
  #       name: 'New Order Item Group',
  #       quantity: 1,
  #       order_id: 1,
  #       on_sale_price: 100
  #     }
  #     @data = @mints_contact.create_order_item_group(data)
  #
  # ==== Second Example
  #     data = {
  #       name: "",
  #       quantity: 1,
  #       order_id: 1,
  #       sku_id: 1
  #     }
  #     @data = @mints_contact.create_order_item_group(data)
  def create_order_item_group(data)
    @client.raw('post', '/ecommerce/order-items-groups', nil, data_transform(data), @contact_v1_url)
  end

  ##
  # === Update Order Item Group.
  # Update an order item group info if you are related to that order.
  #
  # ==== Parameters
  # id:: (Integer) -- Order Item Group Id.
  # data:: (Hash) -- Data to be submitted.
  #
  # ==== First Example
  #     data = {
  #       name: 'New Order Item Group Name Updated'
  #     }
  #     @data = @mints_contact.update_order_item_group(130, data)
  def update_order_item_group(id, data)
    @client.raw('put', "/ecommerce/order-items-groups/#{id}", nil, data_transform(data), @contact_v1_url)
  end

  ##
  # === Delete Order Item Group.
  # Delete an order item group.
  # FIXME: This method doesn't work. Throw no action error.
  def delete_order_item_group(id)
    @client.raw('delete', "/ecommerce/order-items-groups/#{id}", nil, nil, @contact_v1_url)
  end
end
