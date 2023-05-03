# Mints::User::Content::Forms

```ruby
user = Mints::User.new(mints_url, api_key, session_token)

user.get_forms(options) #=> Get a collection of forms.

user.publish_form(id, data) #=> Publish a form.

user.schedule_form(id, data) #=> Schedule a form in a specified date.

user.revert_published_form(id) #=> Revert a published form.

user.duplicate_form(id) #=> Duplicate a form.

user.get_form_activation_words(id) #=> Get activation words a form.

user.get_form_support_data #=> Get form support data.

user.get_form_submissions(options) #=> Get form submissions.

user.get_form_submission(id, options) #=> Get form submission.

user.delete_form_submission(id) #=> Delete a form submission.

user.get_form(id, options) #=> Get a form info.

user.create_form(data) #=> Create a form with data.

user.update_form(id, data) #=> Update a form info.

user.delete_form(id) #=> Delete a form.

user.get_form_aggregates(id, object_id) #=> Get a form aggregates info.

user.reset_form_aggregates(data) #=> Reset aggregates.
```
