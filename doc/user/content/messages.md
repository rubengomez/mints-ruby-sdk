# Mints::User::Content::Messages

```ruby
user = Mints::User.new(mints_url, api_key, session_token)

user.get_messages(options) #=> Get a collection of messages.

user.get_message(id, options) #=> Get a message info.

user.create_message(data) #=> Create a message.

user.update_message(id, data) #=> Update a message info.

user.delete_message(id) #=> Delete a message.
```
