# Mints::User::Ecommerce::Skus

```ruby
user = Mints::User.new(mints_url, api_key, session_token)

user.get_skus(options) #=> Get a collection of skus.

user.get_sku(id, options) #=> Get a sku info.

user.create_sku(data) #=> Create a sku.

user.update_sku(id, data) #=> Update a sku info.

user.delete_sku(id) #=> Delete a sku.
```