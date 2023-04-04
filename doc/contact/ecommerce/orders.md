# Mints::Contact::Ecommerce::Orders

```ruby
mints_contact = Mints::Contact.new(mints_url, api_key, session_token)

mints_contact.get_orders(options, use_post) #=> Return a collection of orders owned.

mints_contact.get_order(id, options) #=> Return a single order owned.

mints_contact.create_order(data) #=> Create a order.

mints_contact.update_order(id, data) #=> Update an order.

mints_contact.detach_order_item_from_order_item_group(order_item_id, group_id) #=> Detach an order item from an order item group

mints_contact.update_order_item_from_order_item_group(order_item_id, group_id, data) #=> Update an order item data from an order item group

mints_contact.get_my_shopping_cart(options) #=> Return a collection of items in the shopping cart

mints_contact.add_item_to_shopping_cart(data, options) #=> Add an item into a shopping cart.
```