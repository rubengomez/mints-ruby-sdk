# Mints::User::Ecommerce::Products

```ruby
user = Mints::User.new(mints_url, api_key, session_token)

user.update_product_variations_config(product_id, data) #=> Update config of product variations of a product.

user.get_products_support_data #=> Get support data used in products.

user.delete_product(id) #=> Delete a product.

user.publish_product(id, data) #=> Publish a product.

user.schedule_product(id, data) #=> Schedule a product.

user.get_product_variant_options_config(id) #=> Get variant options config used in a product.

user.revert_published_product(id) #=> Revert a published product.

user.get_products(options, use_post) #=> Get a collection of products.

user.get_product(id, options) #=> Get a product info.

user.create_product(data, options) #=> Create a product.

user.update_product(id, data, options) #=> Update a product info.
```