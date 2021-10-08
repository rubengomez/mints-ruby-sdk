module OrderStatuses
    ##
    # == Order Statuses
    #

    # === Get order statuses.
    # Get order statuses.
    #
    # ==== First Example
    #     @data = @mints_user.get_order_statuses
    def get_order_statuses
        return @client.raw("get", "/ecommerce/order-statuses")
    end
    
    # === Get order status.
    # Get status of an order.
    #
    # ==== Parameters
    # id:: (Integer) -- Order id.
    #
    # ==== First Example
    #     @data = @mints_user.get_order_status(1)
    def get_order_status(id)
        return @client.raw("get", "/ecommerce/order-statuses/#{id}")
    end
end