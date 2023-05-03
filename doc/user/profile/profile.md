# Mints::User::Profile

```ruby
user = Mints::User.new(mints_url, api_key, session_token)

user.me(options) #=> Get contact logged info.

user.get_preferences #=> Get preferences of current user logged.

user.create_preferences(data) #=> Create preferences of current user logged with data.

user.get_preferences_by_setting_key(setting_key) #=> Get preferences using a setting key.

user.get_notifications(options) #=> Get a collection of notifications.

user.read_notifications(data) #=> Read notifications by data.

user.delete_notifications(data) #=> Delete notifications by data.
```
