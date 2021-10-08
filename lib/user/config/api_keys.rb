module ApiKeys
    ##
    # == Api keys
    #
    
    # === Get api keys.
    # Get a collection of api keys.
    #
    # ==== Parameters
    # options:: (Hash) -- List of Resource Collection Options shown above can be used as parameter.
    #
    # ==== First Example
    #     @data = @mints_user.get_api_keys
    #
    # ==== Second Example
    #     options = { "fields": "id" }
    #     @data = @mints_user.get_api_keys(options)
    def get_api_keys(options = nil)
        return @client.raw("get", "/config/api-keys", options)
    end

    # === Get api key.
    # Get an api key info.
    #
    # ==== Parameters
    # id:: (Integer) -- Api key id.
    # options:: (Hash) -- List of Resource Collection Options shown above can be used as parameter.
    #
    # ==== First Example
    #     @data = @mints_user.get_api_key(2)
    #
    # ==== Second Example
    #     options = { "fields": "id" }
    #     @data = @mints_user.get_api_key(2, options)
    def get_api_key(id, options = nil)
        return @client.raw("get", "/config/api-keys/#{id}", options)
    end

    # === Create api key.
    # Create an api key with data.
    #
    # ==== Parameters
    # data:: (Hash) -- Data to be submited.
    #
    # ==== Example
    #     data = {
    #       "description": "New Api Key Description"
    #     }
    #     @data = @mints_user.create_api_key(data)
    def create_api_key(data)
        return @client.raw("post", "/config/api-keys", nil, data_transform(data))
    end

    # === Delete api key.
    # Delete an api key.
    #
    # ==== Parameters
    # id:: (Integer) -- Api key id.
    #
    # ==== Example
    #     @data = @mints_user.delete_api_key(2)
    def delete_api_key(id)
        return @client.raw("delete", "/config/api-keys/#{id}")
    end
end