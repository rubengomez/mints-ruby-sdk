# Mints::User::Content::MessageTemplates

```ruby
user = Mints::User.new(mints_url, api_key, session_token)

user.get_variables_of_content_page_from_message_templates(id) #=> Get variables used in a specified content page located in message templates.

user.get_recipient_variables #=> Get recipient variables in message templates.

user.get_driver_templates #=> Get driver templates in message templates.

user.preview_message_template(data) #=> Preview an message template based in data.

user.send_message_template(data) #=> Send an message template to different contacts.

user.duplicate_message_template(id, data) #=> Duplicate an message template.

user.get_message_templates(options) #=> Get a collection of message templates.

user.get_message_template(id, options) #=> Get an message template info.

user.create_message_template(data) #=> Create an message template with data.

user.update_message_template(id, data) #=> Update an message template info.

user.delete_message_template(id) #=> Delete an message template.
```
