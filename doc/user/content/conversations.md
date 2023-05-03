# Mints::User::Content::Conversations

```ruby
user = Mints::User.new(mints_url, api_key, session_token)

user.get_conversations(options) #=> Get a collection of content conversations.

user.get_conversation(id) #=> Get a content conversation.

user.create_conversation(data) #=> Create a content conversation.

user.update_conversation(id, data) #=> Update a content conversation info.

user.delete_conversation(id) #=> Delete a content conversation.

user.update_conversation_status(id, data) #=> Update a conversation status.

user.get_conversation_participants(id) #=> Get participants in a conversation.

user.attach_user_in_conversation(id, data) #=> Attach an user in a conversation.

user.detach_user_in_conversation(id, data) #=> Detach an user in a conversation.

user.attach_contact_in_conversation(id, data) #=> Attach an contact in a conversation.

user.detach_contact_in_conversation(id, data) #=> Detach an contact in a conversation.

user.attach_form_in_conversation(id, data) #=> Attach an form in a conversation.

user.detach_form_in_conversation(id, data) #=> Detach an form in a conversation.

```
