# Mints::User::Config::Teams

```ruby
user = Mints::User.new(mints_url, api_key, session_token)

user.get_team_types #=> Get a collection of team types.

user.get_teams #=> Get a collection of team.

user.get_team(id) #=> Get a single team.

user.create_team(data) #=> Create a team.

user.update_team(id, data) #=> Update a team.
```