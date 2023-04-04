# Mints::User::Content::Dam

```ruby
user = Mints::User.new(mints_url, api_key, session_token)

user.get_dam_load_tree #=> Get dam load_tree.

user.get_dam_asset_locations(options) #=> Get an asset locations in dam.

user.paste_dam(data)

user.rename_dam(data) #=> Rename folder or asset in dam.

user.search_dam(data) #=> Search folder or asset in dam..

user.send_to_trash_dam(data) #=> Send folders to trash in dam.

user.delete_dam(data) #=> Delete folders in dam.

user.create_dam_folder(data) #=> Create a folder in dam.
```
