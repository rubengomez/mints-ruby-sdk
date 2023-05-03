# Mints::User::Crm::Workflows

```ruby
user = Mints::User.new(mints_url, api_key, session_token)

user.get_workflows(options) #=> Get a collection of workflows.

user.get_workflow(id, options) #=> Get a workflow.

user.create_workflow(data) #=> Create a workflow.

user.update_workflow(id, data) #=> Update a workflow info.
```