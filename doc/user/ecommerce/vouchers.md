# Mints::User::Ecommerce::Vouchers

Available since version 0.0.30

```ruby
user = Mints::User.new(mints_url, api_key, session_token)

user.get_vouchers(options, use_post) #=> Get a collection of vouchers.

user.get_voucher(id, options) #=> Get a specific voucher.

user.create_voucher(data) #=> Create voucher code.

user.update_voucher(id, data) #=> Update voucher code.
```