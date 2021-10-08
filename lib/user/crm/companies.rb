module Companies
    ##
    # == Companies
    #

    ##
    # === Get companies support data.
    # Get support data of companies.
    #
    # ==== Example
    #     @data = @mints_user.get_companies_support_data
    def get_companies_support_data
        return @client.raw("get", "/crm/companies/support-data")
    end
  
    # === Get companies.
    # Get a collection of companies.
    #
    # ==== Parameters
    # options:: (Hash) -- List of Resource Collection Options shown above can be used as parameter.
    # use_post:: (Boolean) -- Variable to determine if the request is by 'post' or 'get' functions.
    #
    # ==== First Example
    #     @data = @mints_user.get_companies
    #
    # ==== Second Example
    #     options = { "fields": "id, title", "sort": "-id" }
    #     @data = @mints_user.get_companies(options)
    #
    # ==== Third Example
    #     options = { "fields": "id, title", "sort": "-id" }
    #     @data = @mints_user.get_companies(options, false)
    def get_companies(options = nil, use_post = true)
        return get_query_results("/crm/companies", options, use_post)
    end
  
    # === Get company.
    # Get a company info.
    #
    # ==== Parameters
    # id:: (Integer) -- Company id.
    # options:: (Hash) -- List of Resource Collection Options shown above can be used as parameter.
    #
    # ==== First Example
    #     @data = @mints_user.get_company(21)
    #
    # ==== Second Example
    #     options = { "fields": "id, title" }
    #     @data = @mints_user.get_company(21, options)
    def get_company(id, options = nil)
        return @client.raw("get", "/crm/companies/#{id}", options)
    end
  
    # === Create company.
    # Create a company with data.
    #
    # ==== Parameters
    # data:: (Hash) -- Data to be submited.
    #
    # ==== Example
    #     data = {
    #         "title": "Company Title",
    #         "alias": "Alias",
    #         "website": "www.company.example.com",
    #         "street1": "Company St",
    #         "city": "Company City",
    #         "region": "Company Region",
    #         "postal_code": "12345",
    #         "country_id": 144,
    #         "tax_identifier": nil
    #     }
    #     @data = @mints_user.create_company(data)
    def create_company(data)
        return @client.raw("post", "/crm/companies/", nil, data_transform(data))
    end

    # === Update company.
    # Update a company info.
    #
    # ==== Parameters
    # id:: (Integer) -- Company id.
    # data:: (Hash) -- Data to be submited.
    #
    # ==== Example
    #     data = { 
    #       "title": "Company Title Modified"
    #     }
    #     @data = @mints_user.update_company(23, data)
    def update_company(id, data)
        return @client.raw("put", "/crm/companies/#{id}", nil, data_transform(data))
    end

    ##
    # == Companies Bulk Actions
    #

    # === Delete Companies.
    # Delete a group of companies.
    #
    # ==== Parameters
    # data:: (Hash) -- Data to be submited.
    #
    # ==== Example
    #     data = {
    #       "ids": [ 21, 22 ]
    #     }
    #     @data = @mints_user.delete_companies(data)
    def delete_companies(data)
        return @client.raw("delete", "/crm/companies/delete", nil, data_transform(data))
    end
end