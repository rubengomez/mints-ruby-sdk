# Mints::User::Config::ApiKey

```ruby
user = Mints::User.new(mints_url, api_key, sesion_token)

user.get_api_keys(options) #=> Return a collection of api keys.

user.get_api_key(id, options) #=> Return a single api key.

user.create_api_key(data) #=> Create an api key.

user.delete_api_key(id) #=> Delete an api key.
```