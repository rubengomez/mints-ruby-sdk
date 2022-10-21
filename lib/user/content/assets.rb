module Assets


    ##
    # == Assets
    #
    # === Get assets.
    # Get a collection of assets.
    #
    # ==== Parameters
    # options:: (Hash) -- List of Resource Collection Options shown above can be used as parameter.
    # use_post:: (Boolean) -- Variable to determine if the request is by 'post' or 'get' functions.
    #
    # ==== First Example
    #     @data = @mints_user.get_assets
    #
    # ==== Second Example
    #     options = {
    #       "fields": "id, title"
    #     }
    #     @data = @mints_user.get_assets(options)
    #
    # ==== Third Example
    #     options = {
    #       "fields": "id, title"
    #     }
    #     @data = @mints_user.get_assets(options, true)
    def get_assets(options = nil, use_post = true)
        return get_query_results("/content/assets", options, use_post)
    end

    # === Get asset.
    # Get a asset info.
    #
    # ==== Parameters
    # id:: (Integer) -- Asset id.
    # options:: (Hash) -- List of Resource Collection Options shown above can be used as parameter.
    #
    # ==== First Example
    #     @data = @mints_user.get_asset(1)
    #
    # ==== Second Example
    #     options = {
    #       "fields": "id, title"
    #     }
    #     @data = @mints_user.get_asset(1, options)
    def get_asset(id, options = nil)
        return @client.raw("get", "/content/assets/#{id}", options)
    end

    # === Create asset.
    # Create a asset with data.
    #
    # ==== Parameters
    # data:: (Hash) -- Data to be submitted.
    #
    # ==== Example
    #     data = {
    #       "title": "New Asset",
    #       "slug": "new-asset",
    #     }
    #     @data = @mints_user.create_asset(data)
    def create_asset(data)
        return @client.raw("post", "/content/assets", nil, data_transform(data))
    end

    # === Update asset.
    # Update a asset info.
    #
    # ==== Parameters
    # id:: (Integer) -- Asset id.
    # data:: (Hash) -- Data to be submitted.
    #
    # ==== Example
    #     data = {
    #       "title": "New Asset Modified",
    #       "slug": "new-asset"
    #     }
    #     @data = @mints_user.update_asset(5, data)
    def update_asset(id, data)
        return @client.raw("put", "/content/assets/#{id}", nil, data_transform(data))
    end

    # === Delete asset.
    # Delete a asset.
    #
    # ==== Parameters
    # id:: (Integer) -- Asset id.
    #
    # ==== Example
    #     @data = @mints_user.delete_asset(6)
    def delete_asset(id)
        return @client.raw("delete", "/content/assets/#{id}")
    end

    # === Get asset link info.
    # Get information of an asset by url.
    #
    # ==== Parameters
    # data:: (Hash) -- Data to be submitted.
    #
    # ==== Example
    #     data = { 
    #       "link": "https://www.example.com/img/img.jpg"
    #     }
    #     @data = @mints_user.get_asset_link_info(data.to_json)
    def get_asset_link_info(data)
        return @client.raw("post", "/content/assets/getLinkInfo", nil, data)
    end

    # === Download asset.
    # Get information of an asset.
    #
    # ==== Parameters
    # id:: (Integer) -- Asset id.
    #
    # ==== Example
    #     @data = @mints_user.download_asset(2)
    def download_asset(id) #FIXME: File not found at path, error in result but method works
        return @client.raw("get", "/content/assets/download/#{id}")
    end

    # FIXME: Returns json invalid token
    # def get_asset_thumbnails(id)
    #    return @client.raw("get", "/content/assets/thumbnails/#{id}")
    #end
    
    # === Get asset usage.
    # Get usage of an asset.
    #
    # ==== Parameters
    # options:: (Hash) -- List of Resource Collection Options shown above can be used as parameter.
    def get_asset_usage(options)
        return @client.raw("get", "/content/assets/usage", options)
    end

    # === Get asset info.
    # Get info of an asset. 
    #TODO: Research if is an asset or many assets
    #
    # ==== Parameters
    # options:: (Hash) -- List of Resource Collection Options shown above can be used as parameter.
    def get_asset_info(options)
        return @client.raw("get", "/content/assets/getAssetInfo", options)
    end

    # === Get asset doc types.
    # Get doc types of assets.
    def get_asset_doc_types
        return @client.raw("get", "/content/assets/docTypes")
    end

    # === Get asset public route.
    # Get public route of assets.
    def get_asset_public_route
        return @client.raw("get", "/content/assets/publicRoute")
    end
    
    # === Upload asset.
    # Upload an asset. It can be images, documents and videos.
    #
    # ==== Parameters
    # data:: (Hash) -- Data to be submitted.
    #
    # ==== First Example (with files)
    #
    #
    # ==== Second Example (with urls)
    #     data = {
    #       "title": "asset title",
    #       "description": "asset description",
    #       "link": "https://link/example",
    #       "url-type": "url-image",
    #       "slug": "slug",
    #       "type": "link",
    #       "father_id": 1
    #     }
    #     @data = @mints_user.upload_asset(data.to_json)
    #
    # ==== Third Example (with video)
    #     data = {
    #       "title": "Video Title",
    #       "fileType": "video/mp4",
    #       "type": "video",
    #       "slug": "video-slug",
    #       "status": "not-uploaded",
    #       "ext": "mp4",
    #       "size": 29605264,
    #       "access_token": "access_token",
    #       "name": "Video Title",
    #       "videoData": {
    #         "id": 80313307,
    #         "name": "Video Title",
    #         "type": "video",
    #         "created": "2021-10-19T19:18:17+00:00",
    #         "updated": "2021-10-19T19:18:17+00:00",
    #         "duration": 191.936133,
    #         "hashed_id": "hashed_id",
    #         "progress": 0.14285714285714285,
    #         "status": "queued",
    #         "thumbnail": {
    #           "url": "https://www.example.com/img/img.jpg",
    #           "width": 200,
    #           "height": 120
    #         },
    #         "account_id": 1234567
    #       }
    #     }
    #     @data = @mints_user.upload_asset(data.to_json)
    def upload_asset(data) #TODO: Research a way to upload a File accross sdk
        return @client.raw("post", "/content/assets/upload", nil, data)
    end


    ##
    # == Sizes
    #


    #FIXME: Double get asset sizes method!
    # === Get asset sizes.
    # Get a collection of sizes of an asset.
    #
    # ==== Parameters
    # options:: (Hash) -- List of Resource Collection Options shown above can be used as parameter.    
    def get_asset_sizes(options)
        return @client.raw("get", "/content/assets/sizes", options)
    end

    # === Get asset sizes.
    # Get sizes of an asset.
    #
    # ==== Parameters
    # id:: (Integer) Asset id.
    #
    # ==== Example
    #     @data = @mints_user.get_asset_sizes(2)
    def get_asset_size(id) #FIXME: wrong number of arguments (given 1, expected 0)
        return @client.raw("get", "/content/assets/sizes/#{id}")
    end

    # === Create asset size.
    # Create an asset size by data.
    #
    # ==== Parameters
    # data:: (Hash) -- Data to be submitted.
    #
    # ==== Example
    #     data = {
    #       "aspectRadio": "custom",
    #       "assetId": 23,
    #       "drawPosData": {
    #         "pos": {
    #           "sx": 100,
    #           "sy": 100,
    #           "swidth": 200,
    #           "sheight": 200
    #         }
    #       },
    #       "width": 100,
    #       "height": 100,
    #       "slug": "fuji_size_slug",
    #       "title": "fuji_size",
    #       "variationId": "original"
    #    }
    #    @data = @mints_user.create_asset_size(data.to_json)
    def create_asset_size(data)
        return @client.raw("post", "/content/assets/sizes", nil, data)
    end


    ##
    # == Variations
    #


    # === Get asset variation.
    # Get variation of an asset.
    #
    # ==== Parameters
    # id:: (Integer) Asset variation id. #TODO: Research if is an asset id or an variation id
    #
    # ==== Example
    #     @data = @mints_user.get_asset_sizes(2)
    def get_asset_variation(id)
        #FIXME: Id 1 and 4: Trying to get property 'path' of non-object maybe json conversion is bad
        #FIXME: Id 2 and 3: File not found at path maybe doesnt exist
        return @client.raw("get", "/content/assets/variation/#{id}")
    end

    # === Generate asset variation.
    # Create an asset variation of an existing asset.
    #
    # ==== Parameters
    # data:: (Hash) -- Data to be submitted.
    def generate_asset_variation(data) #FIXME: Trying to get property 'width' of non-object
        return @client.raw("post", "/content/assets/generate-asset-variations", nil, data)
    end
end