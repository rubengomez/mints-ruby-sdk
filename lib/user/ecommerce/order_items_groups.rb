module OrderItemsGroups
    ##
    # == Order Items Groups
    #

    # === Get pending order template from order item group.
    # Get a pending order template from an order item group.
    #
    # ==== Parameters
    # parentOrderId:: (Integer) -- Order items group id.
    # orderTemplateId:: (Integer) -- Order template id.
    #
    # ==== Example
    #     @data = @mints_user.get_pending_order_template_from_order_item_group(1, 1)
    def get_pending_order_template_from_order_item_group(parentOrderId, orderTemplateId)
        return @client.raw("get", "/ecommerce/order-items-groups/#{parentOrderId}/pending-items/order-template/#{orderTemplateId}")
    end
    
    # === Get order item group support data by order id.
    # Get support data of an order item group by an order id.
    #
    # ==== Parameters
    # orderId:: (Integer) -- Order id.
    #
    # ==== Example
    #     @data = @mints_user.get_order_item_group_support_data_by_order_id(1)
    def get_order_item_group_support_data_by_order_id(orderId) #FIXME: Return in OrderItemsGroupController.getTemplateSupportDataByOrderId method doesnt create data variable.
        return @client.raw("get", "/ecommerce/order-items-groups/support-data/#{orderId}")
    end

    # === Get order item groups.
    # Get a collection of order item groups.
    #
    # ==== Parameters
    # options:: (Hash) -- List of Resource Collection Options shown above can be used as parameter.
    #
    # ==== First Example
    #     @data = @mints_user.get_order_item_groups
    #
    # ==== Second Example
    #     options = { "fields": "name" }
    #     @data = @mints_user.get_order_item_groups(options)
    def get_order_item_groups(options = nil)
        return @client.raw("get", "/ecommerce/order-items-groups", options)
    end

    # === Get order item group.
    # Get a order item group info.
    #
    # ==== Parameters
    # id:: (Integer) -- Order item group id.
    # options:: (Hash) -- List of Resource Collection Options shown above can be used as parameter.
    #
    # ==== First Example
    #     @data = @mints_user.get_order_item_group(1)
    #
    # ==== Second Example
    #     options = { "fields": "name" }
    #     @data = @mints_user.get_order_item_group(1, options)
    def get_order_item_group(id, options = nil)
        return @client.raw("get", "/ecommerce/order-items-groups/#{id}", options)
    end
    
    # === Create order item group.
    # Create a order item group with data.
    #
    # ==== Parameters
    # data:: (Hash) -- Data to be submitted.
    #
    # ==== Example
    #     data = {
    #       "name": "New Order Item Group",
    #       "order_id": 1,
    #       "quantity": 1,
    #       "sale_price": 200
    #     }
    #     @data = @mints_user.create_order_item_group(data)
    def create_order_item_group(data)
        return @client.raw("post", "/ecommerce/order-items-groups", nil, data_transform(data))
    end
    
    # === Update order item group.
    # Update a order item group info.
    #
    # ==== Parameters
    # id:: (Integer) -- Order item group id.
    # data:: (Hash) -- Data to be submitted.
    #
    # ==== Example
    #     data = {
    #       "name": "New Order Item Group Modified"
    #     }
    #     @data = @mints_user.update_order_item_group(147, data)
    def update_order_item_group(id, data)
        return @client.raw("put", "/ecommerce/order-items-groups/#{id}", nil, data_transform(data))
    end
    
    # === Delete order item group.
    # Delete a order item group.
    #
    # ==== Parameters
    # id:: (Integer) -- Order item group id.
    #
    # ==== Example
    #     @data = @mints_user.delete_order_item_group(147)
    def delete_order_item_group(id)
        return @client.raw("delete", "/ecommerce/order-items-groups/#{id}")
    end
end