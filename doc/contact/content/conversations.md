# Mints::Contact::Content::Conversations

```ruby
mints_contact = Mints::Contact.new(mints_url, api_key, session_token)

mints_contact.get_conversations(options) #=> Return a collection of conversations.

mints_contact.get_conversation(id, options) #=> Return a single conversation.

mints_contact.create_conversation(data) #=> Create a conversation.

mints_contact.update_conversation(id, data) #=> Update a conversation.

mints_contact.update_conversation_status(id, data) #=> Update a conversation status.

mints_contact.get_conversation_participants(id) #=> Returns a conversation participants.

mints_contact.get_messages(options) #=> Returns a collection of messages.

mints_contact.get_message(id, options) #=> Returns a single message.

mints_contact.create_message(data) #=> Create a message.
```