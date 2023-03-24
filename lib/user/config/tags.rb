# frozen_string_literal: true

module Tags
  ##
  # == Tags
  #
  # === Get tags.
  # Get a collection of tags.
  #
  # ==== Example
  #     @data = @mints_user.get_tags
  def get_tags
    @client.raw('get', '/config/tags')
  end

  # === Get tag.
  # Get a tag info.
  #
  # ==== Parameters
  # id:: (Integer) -- Tag id.
  #
  # ==== Example
  #     @data = @mints_user.get_tag(1)
  def get_tag(id)
    @client.raw('get', "/config/tags/#{id}")
  end

  # === Create tag.
  # Create a tag with data.
  #
  # ==== Parameters
  # data:: (Hash) -- Data to be submitted.
  #
  # ==== Example
  #     data = {
  #       tag: 'new-tag',
  #       is_visible: true
  #     }
  #     @data = @mints_user.create_tag(data)
  def create_tag(data)
    @client.raw('post', '/config/tags', nil, data_transform(data))
  end

  # === Update tag.
  # Update a tag info.
  #
  # ==== Parameters
  # id:: (Integer) -- Tag id.
  # data:: (Hash) -- Data to be submitted.
  #
  # ==== Example
  #     data = {
  #       tag: 'new-tag',
  #       slug: 'new-tag',
  #       is_visible: false
  #     }
  #     @data = @mints_user.update_tag(54, data)
  def update_tag(id, data)
    @client.raw('put', "/config/tags/#{id}", nil, data_transform(data))
  end
end
