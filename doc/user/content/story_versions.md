# Mints::User::Content::StoryVersions

```ruby
user = Mints::User.new(mints_url, api_key, session_token)

user.get_story_versions(options, use_post) #=> Get a collection of story versions.

user.get_story_version(id, options) #=> Get a story version info.

user.create_story_version(data, options) #=> Create a story version.

user.update_story_version(id, data, options) #=> Update a story version info.

user.delete_story_version(id) #=> Delete a story version.

user.duplicate_story_version(id, data) #=> Duplicate a story version.

user.publish_story_version(id, data) #=> Publish a story version.
```
