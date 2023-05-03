# Mints::User::Crm::WorkflowStepObjects

```ruby
user = Mints::User.new(mints_url, api_key, session_token)

user.get_step_objects(options) #=> Get a collection of workflow step objects.

user.get_step_object(id, options) #=> Get a workflow step object info.

user.create_step_object(data) #=> Create a workflow step object 

user.update_step_object(id, data) #=> Update a workflow step object info.

user.get_step_object_by_object_type(object_type, object_id, options) #=> Get a workflow step object info by an object type.
```