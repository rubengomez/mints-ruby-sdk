# Mints::User::Config::SystemSettings

```ruby
user = Mints::User.new(mints_url, api_key, session_token)

user.get_settings_by_keys(options) #=> Get a collection of settings using keys.

user.get_settings #=>  Get a collection of settings.

user.create_setting(data) #=> Create a setting title.

user.clear_tag(tag) #=> Clear a tag info.

```