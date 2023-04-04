# Mints::User::Content::Assets

```ruby
user = Mints::User.new(mints_url, api_key, session_token)

user.get_assets(options, use_post) #=> Get a collection of assets.

user.get_asset(id, options) #=> Get a single asset.

user.create_asset(data) #=> Create an asset.

user.update_asset(id, data) #=> Update an asset.

user.delete_asset(id) #=>Delete an asset.

user.get_asset_link_info(data) #=> Get information of an asset by url.

user.download_asset(id) #=> Get information of an asset.

user.get_asset_thumbnails(id) #=> Get an asset variations.

user.get_asset_usage(options) #=> Get usage of an asset.

user.get_asset_info(options) #=> Get info of an asset.

user.get_asset_doc_types #=> Get doc types of assets.

user.get_asset_public_route #=> Get public route of assets.

user.get_asset_public_route #=> Get public route of assets.

user.upload_asset(data) #=> Upload an asset. It can be images, documents and videos.

user.get_asset_sizes(options) #=> Get a collection of sizes of an asset.

user.get_asset_size(id) #=> Get sizes of an asset.

user.create_asset_size(data) #=> Create an asset size by data.

user.get_asset_variation(id) #=> Get variation of an asset.

user.generate_asset_variation(data) #=> Create an asset variation of an existing asset.

```