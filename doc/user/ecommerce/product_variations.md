# Mints::User::Ecommerce::ProductVariations

```ruby
user = Mints::User.new(mints_url, api_key, session_token)

user.generate_product_variation(product_id, data) #=> Generate a product variation.

user.set_prices_to_product_variations(data) #=> Set prices to product variations.

user.get_product_from_product_variation(product_id) #=> Get a product from a product variation.

user.get_product_variations #=> Get a collection of product variations.

user.get_product_variation(id) #=> Get a product variation info.

user.create_product_variation(data) #=> Create a product variation with data.

user.update_product_variation(id, data) #=> Update a product variation info.

user.delete_product_variation(id) #=> Delete a product variation.
```