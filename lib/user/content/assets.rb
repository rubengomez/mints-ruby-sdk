module Assets
    ##
    # == Assets
    #

    def upload_asset(data)
        return @client.raw("post", "/content/assets/upload", nil, data)
    end

    # === Get asset link info.
    # Get information of an asset by url.
    #
    # ==== Parameters
    # data:: (Hash) -- Data to be submited.
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
    # * +id+ - [Integer] Asset id.
    #
    # ==== Example
    #     @data = @mints_user.download_asset(2)
    def download_asset(id) #FIXME: File not found at path, error in result but method works
        return @client.raw("get", "/content/assets/download/#{id}")
    end

    def edit_asset_size(data) #TODO: Not tested
        return @client.raw("post", "/content/assets/editSize", nil, data)
    end

    def upload_asset_variation(data) #FIXME: Call to a member function guessClientExtension() on null
        return @client.raw("post", "/content/assets/uploadVariation", nil, data)
    end

    def create_asset_size(data) #FIXME: Trying to get property 'path' of non-object
        return @client.raw("post", "/content/assets/createSize", nil, data)
    end

    def update_asset_variation(id, data) #TODO:
        return @client.raw("post", "/content/assets/updateVariation/#{id}", nil, data)
    end

    def get_asset_sizes(id) #FIXME: wrong number of arguments (given 1, expected 0)
        return @client.raw("get", "/content/assets/sizes/#{id}")
    end

    def get_original_asset(id) #FIXME: Doesn't return JSON
        return @client.raw("get", "/content/assets/original/#{id}")
    end

    def get_asset_variation(id)
        #FIXME: Id 1 and 4: Trying to get property 'path' of non-object
        #FIXME: Id 2 and 3: File not found at path maybe doesnt exist
        return @client.raw("get", "/content/assets/variation/#{id}")
    end

    def get_asset_sizes(options)
        return @client.raw("get", "/content/assets/getSizes", options)
    end

    def get_asset_usage(options)
        return @client.raw("get", "/content/assets/usage", options)
    end

    def delete_asset_variation #TODO: Not tested
        return @client.raw("get", "/content/assets/deleteVariation")
    end

    def delete_asset_size #TODO: Not tested
        return @client.raw("get", "/content/assets/deleteSize")
    end

    def get_asset_info(options)
        return @client.raw("get", "/content/assets/getAssetInfo", options)
    end

    def generate_asset_variation(data) #FIXME: Trying to get property 'width' of non-object
        return @client.raw("post", "/content/assets/generateAssetVariations", nil, data)
    end

    def get_asset_doc_types
        return @client.raw("get", "/content/assets/docTypes")
    end

    def get_asset_public_route
        return @client.raw("get", "/content/assets/publicRoute")
    end
end