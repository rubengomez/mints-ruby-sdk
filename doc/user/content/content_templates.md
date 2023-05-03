# Mints::User::Content::ContentTemplates

```ruby
user = Mints::User.new(mints_url, api_key, session_token)

user.get_content_templates(options) #=> Get a collection of content templates.

user.get_content_template(id) #=> Get a content template.

user.create_content_template(data) #=> Create a content template.

user.update_content_template(id, data) #=> Update a content template info.

user.delete_content_template(id) #=> Delete a content template.

user.duplicate_content_template(id) #=> Duplicate a content template.

user.get_content_template_instances(template_id) #=> Get instances of a content template.
```
