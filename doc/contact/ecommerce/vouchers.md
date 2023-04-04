# Mints::Contact::Ecommerce::Vouchers

Available since version 0.0.30

```ruby
mints_contact = Mints::Contact.new(mints_url, api_key, session_token)

mints_contact.apply_voucher(order_id, data) #=> Apply voucher code to the existing order, only applies to sale orders.
```