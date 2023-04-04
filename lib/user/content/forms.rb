# frozen_string_literal: true

module Forms
  ##
  # == Forms
  #

  # === Get forms.
  # Get a collection of forms.
  #
  # ==== Parameters
  # options:: (Hash) -- List of Resource Collection Options shown above can be used as parameter.
  #
  # ==== First Example
  #     @data = @mints_user.get_forms
  #
  # ==== Second Example
  #     options = { sort: 'id', fields: 'title' }
  #     @data = @mints_user.get_forms(options)
  def get_forms(options = nil)
    @client.raw('get', '/content/forms', options)
  end

  # === Publish form.
  # Publish a form.
  #
  # ==== Parameters
  # id:: (Integer) -- Form id.
  # data:: (Hash) -- Data to be submitted.
  #
  # ==== Example
  #     data = {
  #       slug: "new-publish"
  #     }
  #     @data = @mints_user.publish_form(1, data)
  def publish_form(id, data)
    # FIXME: Output cannot be processed. response cannot be converted to json.
    @client.raw('put', "/content/forms/#{id}/publish", nil, data_transform(data))
  end

  # === Schedule form.
  # Schedule a form in a specified date.
  #
  # ==== Parameters
  # id:: (Integer) -- Form id.
  # data:: (Hash) -- Data to be submitted.
  #
  # ==== Example
  #     data = {
  #       scheduled_at: '2021-09-06T20:29:16+00:00'
  #     }
  #     @data = @mints_user.schedule_form(1, data.to_json)
  def schedule_form(id, data)
    # FIXME: Output cannot be processed. response cannot be converted to json.
    @client.raw('put', "/content/forms/#{id}/schedule", nil, data_transform(data))
  end

  # === Revert published form.
  # Revert a published form.
  #
  # ==== Parameters
  # id:: (Integer) -- Form id.
  #
  # ==== Example
  #     @data = @mints_user.revert_published_form(1)
  def revert_published_form(id)
    @client.raw('get', "/content/forms/#{id}/revert-published-data")
  end

  # === Duplicate form.
  # Duplicate a form.
  #
  # ==== Parameters
  # id:: (Integer) -- Form id.
  #
  # ==== Example
  #     @data = @mints_user.duplicate_form(3)
  def duplicate_form(id)
    @client.raw('post', "/content/forms/#{id}/duplicate")
  end

  # === Get activation words form.
  # Get activation words a form.
  #
  # ==== Parameters
  # id:: (Integer) -- Form id.
  #
  # ==== Example
  #     @data = @mints_user.get_form_activation_words(3)
  def get_form_activation_words(id)
    @client.raw('post', "/content/forms/#{id}/activation-words")
  end

  # === Get form support data.
  # Get form support data.
  #
  # ==== Example
  #     @data = @mints_user.get_form_support_data
  def get_form_support_data
    @client.raw('get', '/content/forms/support-data')
  end

  # === Get form submissions.
  # Get form submissions.
  #
  # ==== Parameters
  # options:: (Hash) -- List of Resource Collection Options shown above can be used as parameter.
  #
  # ==== First Example
  #     @data = @mints_user.get_form_submissions
  #
  # ==== Second Example
  #     options = { fields: 'id' }
  #     @data = @mints_user.get_form_submissions(options)
  def get_form_submissions(options = nil)
    @client.raw('get', '/content/forms/submissions', options)
  end

  # === Get form submission.
  # Get form submission.
  #
  # ==== Parameters
  # options:: (Hash) -- List of Resource Collection Options shown above can be used as parameter.
  #
  # ==== First Example
  #     @data = @mints_user.get_form_submissions
  #
  # ==== Second Example
  #     options = { fields: 'id' }
  #     @data = @mints_user.get_form_submissions(options)
  def get_form_submission(id, options)
    @client.raw('get', "/content/forms/submissions/#{id}", options)
  end

  # === Delete form submission.
  # Delete a form submission.
  #
  # ==== Parameters
  # id:: (Integer) -- Form submission id.
  #
  # ==== Example
  #     @data = @mints_user.delete_form_submission(1)
  def delete_form_submission(id)
    @client.raw('delete', "/content/forms/submissions/#{id}")
  end

  # === Get form.
  # Get a form info.
  #
  # ==== Parameters
  # id:: (Integer) -- Form id.
  # options:: (Hash) -- List of Resource Collection Options shown above can be used as parameter.
  #
  # ==== First Example
  #     @data = @mints_user.get_form(9)
  #
  # ==== Second Example
  #     options = { sort: 'id', fields: 'title' }
  #     @data = @mints_user.get_form(2, options)
  def get_form(id, options = nil)
    @client.raw('get', "/content/forms/#{id}", options)
  end

  # === Create form.
  # Create a form with data.
  #
  # ==== Parameters
  # data:: (Hash) -- Data to be submitted.
  #
  # ==== Example
  #     data = {
  #       title: 'New Form',
  #       slug: 'new-form-slug'
  #     }
  #     @data = @mints_user.create_form(data)
  def create_form(data, options = nil)
    @client.raw('post', '/content/forms', options, data_transform(data))
  end

  # === Update form.
  # Update a form info.
  #
  # ==== Parameters
  # id:: (Integer) -- Form id.
  # data:: (Hash) -- Data to be submitted.
  #
  # ==== Example
  #     data = {
  #       title: 'New Form Modified',
  #       slug: 'new-form-slug'
  #     }
  #     @data = @mints_user.update_form(3, data)
  def update_form(id, data, options = nil)
    @client.raw('put', "/content/forms/#{id}", options, data_transform(data))
  end

  # === Delete form.
  # Delete a form.
  #
  # ==== Parameters
  # id:: (Integer) -- Form id.
  #
  # ==== Example
  #     @data = @mints_user.delete_form(9)
  def delete_form(id)
    @client.raw('delete', "/content/forms/#{id}")
  end

  # === Get form aggregates.
  # Get a form aggregates info.
  #
  # ==== Parameters
  # id:: (Integer) -- Form id.
  # object_id:: (Integer) -- Object id.
  # ==== First Example
  #     @data = @mints_user.get_form_aggregates(1)
  def get_form_aggregates(id, object_id)
    @client.raw('get', "/content/forms/#{id}/aggregates?object_id=#{object_id}", options)
  end

  # === Reset aggregates.
  #
  # ==== Parameters
  # data:: (Hash) -- Data to be submitted.
  #
  # ==== Example
  #     data = { object_id: 1 }
  #     @data = @mints_user.reset_form_aggregates(data)
  def reset_form_aggregates(data)
    @client.raw('post', "/content/forms/#{id}/aggregates", nil, data_transform(data))
  end
end
