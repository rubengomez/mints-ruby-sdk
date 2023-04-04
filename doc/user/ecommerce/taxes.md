# Mints::User::Ecommerce::Taxes

```ruby
user = Mints::User.new(mints_url, api_key, session_token)

user.get_taxes(options) #=> Get a collection of taxes.

user.get_tax(id, options) #=> Get a tax info.

user.create_tax(data) #=> Create a tax.

user.update_tax(id, data) #=> Update a tax info.

user.delete_tax(id) #=> Delete a tax.
```