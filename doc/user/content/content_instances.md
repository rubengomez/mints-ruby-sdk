# Mints::User::Content::ContentInstances

```ruby
user = Mints::User.new(mints_url, api_key, session_token)

user.get_content_instances(options) #=> Get a collection of content instances.

user.get_content_instance(id) #=> Get a content instance.

user.create_content_instance(data) #=> Create a content instance.

user.update_content_instance(id, data) #=> Update a content instance info.

user.delete_content_instance(id) #=> Delete a content instance.

user.duplicate_content_instance(id, data) #=> Duplicate a content instance.

user.publish_content_instance(id, data) #=> Publish a content instance.

user.schedule_content_instance(id, data) #=> Schedule a content instance in a specified date.

user.revert_published_content_instance(id) #=> Revert a published content instance.

```
