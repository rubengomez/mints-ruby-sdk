# Mints::User::Ecommerce::ItemPrices

```ruby
user = Mints::User.new(mints_url, api_key, session_token)

user.get_item_prices(options) #=> Get a collection of item prices.

user.get_item_price(id, options) #=> Get a item price info.

user.create_item_price(data) #=> Create a item price.

user.update_item_price(id, data) #=> Update a item price info.

user.delete_item_price(id) #=> Delete a item price.
```