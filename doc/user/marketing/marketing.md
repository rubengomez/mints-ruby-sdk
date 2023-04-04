# Mints::User::Marketing

```ruby
user = Mints::User.new(mints_url, api_key, session_token)

user.get_automations(options) #=> Get a collection of automations.

user.get_automation(id, options) #=> Get an automation info.

user.create_automation(data) #=> Create an automation

user.update_automation(id, data) #=> Update an automation info.

user.delete_automation(id) #=> Delete an automation.

user.get_automation_executions(id) #=> Get executions of an automation.

user.reset_automation(id) #=> Reset an automation.

user.duplicate_automation(id, data) #=> Duplicate an automation.
```
