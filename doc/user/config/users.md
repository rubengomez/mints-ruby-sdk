# Mints::User::Config::Users

```ruby
user = Mints::User.new(mints_url, api_key, session_token)

user.can_users_coach #=> Determine if users can coach.

user.get_users(options) #=> Get a collection of users.

user.get_user(id) #=> Get a single user.

user.create_user(data) #=> Create a user.

user.update_user(id, data) #=> Update a user.
```