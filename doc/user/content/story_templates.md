# Mints::User::Content::StoryTemplates

```ruby
user = Mints::User.new(mints_url, api_key, session_token)

user.get_story_template_support_data(id) #=> Get support data used in a story template.

user.get_story_templates_support_data #=> Get support data used in story templates.

user.get_story_templates(options) #=> Get a collection of story templates.

user.get_story_template(id, options) #=> Get a story template info.

user.create_story_template(data) #=> Create a story template with data.

user.update_story_template(id, data) #=> Update a story template info.
```
