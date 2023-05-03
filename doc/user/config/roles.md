# Mints::User::Config::Roles

```ruby
user = Mints::User.new(mints_url, api_key, session_token)

user.duplicate_role(id, data) #=> Duplicate a role.

user.get_roles #=> Get a collection of roles.

user.get_role(id) #=> Get a single role.

user.create_role(data) #=> Create a role.

user.update_role(id, data) #=> Update a role.
```