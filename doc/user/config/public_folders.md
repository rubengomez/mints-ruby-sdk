# Mints::User::Config::PublicFolders

```ruby
user = Mints::User.new(mints_url, api_key, session_token)

user.sync_public_folders_for_object(data) #=> Sync public folders for object.

user.get_public_folders_for_object(options) #=> get_public_folders_for_object

user.get_public_folders(options) #=> Get a collection of public folders.

user.create_public_folder(data) #=> Create a public folder.

user.update_public_folder(id, data) #=> Update a public folder.

user.get_public_folder_support_data(id) #=> Get support data used in a public folder.

user.get_public_folder(id) #=> Get a public folder.
```