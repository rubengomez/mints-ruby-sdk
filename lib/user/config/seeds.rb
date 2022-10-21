module Seeds
    ##
    # == Seeds
    #

    # === Apply seeds.
    # Apply seeds.
    #
    # ==== Example
    #
    def apply_seeds(data, async = false)
        url = "/config/seeds"
        url = "#{url}?async" if async
        return @client.raw("post", url, nil, data)
    end

    # === Get seed processes.
    # Get a collection of seed processes.
    #
    # ==== Parameters
    # options:: (Hash) -- List of Resource Collection Options shown above can be used as parameter.
    # use_post:: (Boolean) -- Variable to determine if the request is by 'post' or 'get' functions.
    #
    # ==== First Example
    #     @data = @mints_user.get_seed_processes
    #
    # ==== Second Example
    #     options = {
    #       "fields": "id"
    #     }
    #     @data = @mints_user.get_seed_processes(options)
    def get_seed_processes(options = nil)
        return @client.raw("post", "/config/seed-processes", options)
    end

    # === Get seed process.
    # Get a seed process info.
    #
    # ==== Parameters
    # id:: (Integer) -- Story version id.
    # options:: (Hash) -- List of Resource Collection Options shown above can be used as parameter.
    #
    # ==== First Example
    #     @data = @mints_user.get_story_version(1)
    #
    # ==== Second Example
    #     options = {
    #       "fields": "id, title"
    #     }
    #     @data = @mints_user.get_seed_process(1, options)
    def get_seed_process(id, options = nil)
        return @client.raw("get", "/config/seed-processes/#{id}", options)
    end
end