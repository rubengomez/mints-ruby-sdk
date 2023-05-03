# Mints::User::Ecommerce::Orders

```ruby
user = Mints::User.new(mints_url, api_key, session_token)

user.duplicate_order(order_id, data) #=> Duplicate an order.

user.delete_orders(data) #=> Delete orders.

user.get_orders_support_data #=> Get support data used in orders.

user.get_orders(options, use_post) #=> Get a collection of orders.

user.get_order(id, options) #=> Get a order info.

user.create_order(data, options) #=> Create a order.

user.update_order(id, data, options) #=> Update a order info.

user.get_order_template_support_data(id) #=> Get support data from a order template.

user.get_order_templates(options) #=> Get a collection of order templates.

user.get_order_template(id, options) #=> Get a order template info.

user.update_order_template(id, data) #=> Update a order template info.

user.get_order_items_support_data #=> Get support data used in order items.

user.detach_order_item_from_order_item_group(order_item_id, group_id) #=> Detach an order item from an order item group.

user.update_order_item_from_order_item_group(order_item_id, group_id, data) #=> Update an order item data from an order item group.

user.get_order_items(options) #=> Get a collection of order items.

user.get_order_item(id, options) #=> Get a order item info.

user.update_order_item(id, data) #=> Update a order item info.
```