# Mints::User::Config::Relationships

```ruby
user = Mints::User.new(mints_url, api_key, session_token)

user.get_relationships_available_for(options) #=> Get relationships available.

user.attach_relationship(data) #=> Attach a relationship.

user.detach_relationship(data) #=> Detach a relationship.

user.relationship_has_objects(id) #=> Get relationships that has objects.

user.get_relationships(options) #=> Get a collection of relationships.

user.get_relationship(id, options) #=> Get a single relationship.

user.create_relationship(data) #=> Create a relationship.

user.update_relationship(id, data) #=> Update a relationship.

user.delete_relationship(id) #=> Delete a relationship.
```