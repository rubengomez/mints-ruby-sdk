# Mints::User::Ecommerce::ProductTemplates

```ruby
user = Mints::User.new(mints_url, api_key, session_token)

user.get_product_templates_support_data_from_product(id) #=> Get product templates support data from a product.

user.get_product_templates_support_data_from_order_items_group(id) #=> Get product templates support data from a order items group.

user.get_product_templates_support_data #=> Get support data used in product templates.

user.get_product_templates(options) #=> Get a collection of product templates.

user.get_product_template(id, options) #=> Get a product template info.

user.create_product_template(data) #=> Create a product template.

user.update_product_template(id, data) #=> Update a product template info.
```