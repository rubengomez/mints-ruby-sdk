# Mints::User::Helpers

```ruby
user = Mints::User.new(mints_url, api_key, session_token)

user.slugify(data) #=> Slugify a text using an object type.

user.get_available_types_from_usage(usage) #=> Get available types by usage.

user.get_magic_link_config #=> Get config used in magic links.

user.get_activities_by_object_type_and_id(object_type, id) #=> Get activities using an object type and object type id.

user.get_dice_coefficient(options) #=> Get dice coefficient.

user.get_permission_menu #=> Get permission menu.

user.generate_seed(object_type, id) #=> Generate seed using object type and object type id.
```
