# Mints::User::Config::Taxonomies

```ruby
user = Mints::User.new(mints_url, api_key, session_token)

user.sync_taxonomies_for_object(data) #=> Sync taxonomies for object.

user.get_taxonomies_for_object(options) #=> Get taxonomies for object

user.get_taxonomies_support_data #=> Get support data used in taxonomies.

user.get_taxonomies(options, use_post) #=> Get a collection of taxonomies.

user.get_taxonomy(id, options) #=> Get a single taxonomy.

user.create_taxonomy(data, options) #=> Create a taxonomy and return the same data as show method.

user.update_taxonomy(id, data, options) #=> Update a taxonomy and return the same data as show method.

```