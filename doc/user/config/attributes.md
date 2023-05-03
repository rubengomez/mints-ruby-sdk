# Mints::User::Config::Attributes

```ruby
user = Mints::User.new(mints_url, api_key, session_token)

user.get_attributes_data_types #=> Return a collection of appointments.

user.get_sub_attributes(options) #=> Get sub attributes with a slug.

user.get_attributes #=> Get a collection of attributes.

user.get_attribute(id) #=> Get an attribute info.

user.create_attribute(data) #=> Create an attribute with data.

user.update_attribute(id, data) #=> Update an attribute.
```