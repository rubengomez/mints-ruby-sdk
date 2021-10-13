module Pages
    ##
    # == Pages
    #

    ###
    # === Get page groups.
    # Get page groups.
    #
    # ==== Example
    #     @data = @mints_user.get_page_groups
    def get_page_groups
        return @client.raw("get", "/content/pages/groups")
    end

    # === Get pages.
    # Get a collection of pages.
    #
    # ==== Example
    #     @data = @mints_user.get_pages
    def get_pages
        return @client.raw("get", "/content/pages")
    end

    # === Get page.
    # Get a page.
    #
    # ==== Parameters
    # id:: (Integer) -- Page id.
    #
    # ==== Example
    #     @data = @mints_user.get_page(1)
    def get_page(id)
        return @client.raw("get", "/content/pages/#{id}")
    end

    # === Create page.
    # Create a page with data.
    #
    # ==== Parameters
    # data:: (Hash) -- Data to be submited.
    #
    # ==== Example
    #     data = { 
    #       "title": "New Page",
    #       "slug": "new-page-slug",
    #       "description": "New page description"
    #     }
    #     @data = @mints_user.create_page(data)
    def create_page(data)
        return @client.raw("post", "/content/pages", nil, data_transform(data))
    end

    # === Update page.
    # Update a page info.
    #
    # ==== Parameters
    # id:: (Integer) -- Page id.
    # data:: (Hash) -- Data to be submited.
    #
    # ==== Example
    #     data = { 
    #       "title": "New Page Modified"
    #     }
    #     @data = @mints_user.update_page(5, data.to_json)
    def update_page(id, data)
        return @client.raw("put", "/content/pages/#{id}", nil, data)
    end

    # === Delete page.
    # Delete a page.
    #
    # ==== Parameters
    # id:: (Integer) -- Page id.
    #
    # ==== Example
    #     @mints_user.@mints_user.delete_page(3)
    def delete_page(id)
        return @client.raw("delete", "/content/pages/#{id}")
    end
end