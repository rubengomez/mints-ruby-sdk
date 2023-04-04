# Mints::User::Ecommerce::PriceList

```ruby
user = Mints::User.new(mints_url, api_key, session_token)

user.get_price_lists(options, use_post) #=> Get a collection of price lists.

user.get_price_list(id, options) #=> Get a price list info.

user.create_price_list(data) #=> Create a price list with data.

user.update_price_list(id, data) #=> Update a price list info.
```