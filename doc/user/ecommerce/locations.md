# Mints::User::Ecommerce::Locations

```ruby
user = Mints::User.new(mints_url, api_key, session_token)

user.get_locations(options, use_post) #=> Get a collection of locations.

user.get_location(id, options) #=> Get a location info.

user.create_location(data, options) #=> Create a location.

user.update_location(id, data, options) #=> Update a location info.

user.delete_location(id) #=> Delete a location.

user.get_location_template_support_data(id) #=> Get support data used in a location template.

user.get_location_templates_support_data #=> Get support data used in location templates.

user.get_location_templates(options) #=> Get a collection of location templates.

user.get_location_template(id, options) #=> Get a location template info.

user.create_location_template(data) #=> Create a location template.

user.update_location_template(id, data) #=> Update a location template info.
```