module Segments
  ##
  # == Segments
  #

  # === Get segments support data.
  # Get segments support data.
  #
  # ==== Example
  #     @data = @mints_user.get_segments_support_data
  def get_segments_support_data
    @client.raw('get', '/crm/segments/support-data')
  end

  # === Get segments attributes.
  # Get segments attributes.
  #
  # ==== Parameters
  # options:: (Hash) -- List of Resource Collection Options shown above can be used as parameter.
  #
  # ==== Example
  #     options = { object_type: 'contacts' }
  #     @data = @mints_user.get_segments_attributes(options)
  def get_segments_attributes(options = nil)
    @client.raw('get', '/crm/segments/attributes', options)
  end

  # === Get segment group.
  # Get segment group.
  #
  # ==== Parameters
  # group_id:: (String) -- Group's name.
  #
  # ==== Example
  #     @data = @mints_user.get_segment_group("users")
  def get_segment_group(group_id)
    @client.raw('get', "/crm/segments/groups/#{group_id}")
  end

  # === Duplicate segment.
  # Duplicate a segment.
  #
  # ==== Parameters
  # id:: (Integer) -- Segment id.
  # data:: (Hash) -- Data to be submitted.
  #
  # ==== Example
  #     data = { options: [] }
  #     @data = @mints_user.duplicate_segment(107, data)
  def duplicate_segment(id, data)
    @client.raw('post', "/crm/segments/#{id}/duplicate", nil, data)
  end

  # === Get segments.
  # Get a collection of segments.
  #
  # ==== Parameters
  # options:: (Hash) -- List of Resource Collection Options shown above can be used as parameter.
  #
  # ==== First Example
  #     @data = @mints_user.get_segments
  #
  # ==== Second Example
  #     options = { fields: 'id', sort: '-id' }
  #     @data = @mints_user.get_segments(options)
  def get_segments(options = nil)
    @client.raw('get', '/crm/segments', options)
  end

  # === Get segment.
  # Get a segment info.
  #
  # ==== Parameters
  # id:: (Integer) -- Segment id.
  # options:: (Hash) -- List of Resource Collection Options shown above can be used as parameter.
  #
  # ==== First Example
  #     @data = @mints_user.get_segment(1)
  #
  # ==== Second Example
  #     options = { fields: 'id, title' }
  #     @data = @mints_user.get_segment(1, options)
  def get_segment(id, options = nil)
    @client.raw('get', "/crm/segments/#{id}", options)
  end

  # === Create segment.
  # Create a segment with data.
  #
  # ==== Parameters
  # data:: (Hash) -- Data to be submitted.
  #
  # ==== Example
  #     data = {
  #       title: 'New Segment',
  #       object_type: 'deals'
  #     }
  #     @data = @mints_user.create_segment(data)
  def create_segment(data)
    @client.raw('post', '/crm/segments', nil, data_transform(data))
  end

  # === Update segment.
  # Update a segment info.
  #
  # ==== Parameters
  # id:: (Integer) -- Segment id.
  # data:: (Hash) -- Data to be submitted.
  #
  # ==== Example
  #     data = {
  #       title: 'New Segment Modified'
  #     }
  #     @data = @mints_user.update_segment(118, data)
  def update_segment(id, data)
    @client.raw('put', "/crm/segments/#{id}", nil, data_transform(data))
  end

  # === Delete segment.
  # Delete a segment.
  #
  # ==== Parameters
  # id:: (Integer) -- Segment id.
  #
  # ==== Example
  #     @mints_user.delete_segment(113)
  def delete_segment(id)
    @client.raw('delete', "/crm/segments/#{id}")
  end
end
