# Mints::Pub::Ecommerce::Products

```ruby
mints_pub = Mints::Pub.new(mints_url, api_key)

mints_pub.get_products(options, use_post) #=> Return a collection of products.

mints_pub.get_product('product-slug', options = nil) #=> Return a single product.

```