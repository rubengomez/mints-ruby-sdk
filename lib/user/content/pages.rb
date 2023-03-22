module Pages
  ##
  # == Content Pages
  #

  ###
  # === Get page groups.
  # Get content page groups.
  #
  # ==== Example
  #     @data = @mints_user.get_page_groups
  def get_page_groups
    @client.raw('get', '/content/pages/groups')
  end

  # === Get pages.
  # Get a collection of content pages.
  #
  # ==== Example
  #     @data = @mints_user.get_pages
  def get_pages(options = nil)
    @client.raw('get', '/content/pages', options)
  end

  # === Get bundles.
  # Get a collection of content pages.
  #
  # ==== Example
  #     @data = @mints_user.get_pages
  def get_bundles(options = nil)
    @client.raw('get', '/content/pages', options)
  end

  # === Get page.
  # Get a content page.
  #
  # ==== Parameters
  # id:: (Integer) -- Page id.
  #
  # ==== Example
  #     @data = @mints_user.get_page(1)
  def get_page(id)
    @client.raw('get', "/content/pages/#{id}")
  end

  # === Create page.
  # Create a content page with data.
  #
  # ==== Parameters
  # data:: (Hash) -- Data to be submitted.
  #
  # ==== Example
  #     data = { 
  #       title: "New Page",
  #       slug: "new-page-slug",
  #       description: "New page description"
  #     }
  #     @data = @mints_user.create_page(data)
  def create_page(data)
    @client.raw('post', '/content/pages', nil, data_transform(data))
  end

  # === Update page.
  # Update a content page info.
  #
  # ==== Parameters
  # id:: (Integer) -- Page id.
  # data:: (Hash) -- Data to be submitted.
  #
  # ==== Example
  #     data = { 
  #       title: "New Page Modified"
  #     }
  #     @data = @mints_user.update_page(5, data.to_json)
  def update_page(id, data)
    @client.raw('put', "/content/pages/#{id}", nil, data)
  end

  # === Delete page.
  # Delete a content page.
  #
  # ==== Parameters
  # id:: (Integer) -- Page id.
  #
  # ==== Example
  #     @mints_user.@mints_user.delete_page(3)
  def delete_page(id)
    @client.raw('delete', "/content/pages/#{id}")
  end
end
