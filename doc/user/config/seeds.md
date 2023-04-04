# Mints::User::Config::Seeds

```ruby
user = Mints::User.new(mints_url, api_key, session_token)

user.apply_seeds(data, async: true) #=> Apply seeds.

user.get_seed_processes(options) #=> Get a collection of seed processes.

user.get_seed_process(id, options) #=> Get a seed process info.
```