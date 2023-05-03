# Mints::Contact::Ecommerce::OrderItemGroups

```ruby
mints_contact = Mints::Contact.new(mints_url, api_key, session_token)

mints_contact.get_order_item_groups(options) #=> Return a collection of order item groups owned.

mints_contact.get_order_item_group(id, options) #=> Return a single order item group owned.

mints_contact.create_order_item_group(data) #=> Create an order item group with data if you are related to that order.

mints_contact.update_order_item_group(id, data) #=> Update an order item group info if you are related to that order.

mints_contact.delete_order_item_group(id) #=> Delete an order item group owned.
```