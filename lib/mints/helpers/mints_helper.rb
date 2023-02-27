
module MintsHelper
    # === Get query results.
    # Method used to give the options to make a 'post' or 'get' request.
    #
    # ==== Parameters
    # url:: (String) -- Url to make the request.
    # options:: (Hash) -- List of {Resource collection Options}[#class-Mints::User-label-Resource+collections+options+] shown above can be used as parameter.
    # use_post:: (Boolean) -- Variable to determine if the request is by 'post' or 'get' functions.
    #
    def get_query_results(url, options = nil, use_post = true)
        if use_post
            @client.raw("post", "#{url}/query", options)
        else
            @client.raw("get", url, options)
        end
    end

    # === Data transform.
    # Transform a 'data' variable to a standardized 'data' variable.
    #
    # ==== Parameters
    # data:: (Hash) -- Data to be submitted.
    #
    def data_transform(data)
        data = correct_json(data)

        unless data[:data]
            data = {data: data}
        end

        data.to_json
    end

    # === Correct json.
    # Receives a json data and convert it to a symbolized object.
    #
    # ==== Parameters
    # data:: (Hash) -- Data to be submitted.
    #
    def correct_json(data)
        if data.is_a? String
            data = JSON.parse(data)
        end

        data.symbolize_keys
    end

end