# Mints::User::Ecommerce::OrderItemGroups

```ruby
user = Mints::User.new(mints_url, api_key, session_token)

user.get_pending_order_template_from_order_item_group(parent_order_id, order_template_id) #=> Get a pending order template from an order item group.

user.get_order_item_group_support_data_by_order_id(order_id) #=> Get support data of an order item group by an order id.

user.get_order_item_groups(options) #=> Get a collection of order item groups.

user.get_order_item_group(id, options) #=> Get a order item group info.

user.create_order_item_group(data, options) #=> Create a order item group.

user.update_order_item_group(id, data) #=> Update a order item group info.

user.delete_order_item_group(id) #=> Delete a order item group.
```