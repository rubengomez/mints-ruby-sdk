# frozen_string_literal: true

module Deals
  ##
  # == Deals
  #

  ##
  # === Get deal permits.
  # Get permits of a deal.
  #
  # ==== Parameters
  # id:: (Integer) -- Deal id.
  #
  # ==== Example
  #     @data = @mints_user.get_deal_permits(7)
  def get_deal_permits(id)
    @client.raw('get', "/crm/deals/#{id}/permits")
  end

  ##
  # === Get deal support data.
  # Get support data of deals.
  #
  # ==== Example
  #     @data = @mints_user.get_deal_support_data
  def get_deal_support_data
    @client.raw('get', '/crm/deals/support-data')
  end

  ##
  # === Get deal currencies.
  # Get currencies of deals.
  #
  # ==== Example
  #     @data = @mints_user.get_deal_currencies
  def get_deal_currencies
    @client.raw('get', '/crm/deal/currencies')
  end

  # === Get deals.
  # Get a collection of deals.
  #
  # ==== Parameters
  # options:: (Hash) -- List of Resource Collection Options shown above can be used as parameter.
  # use_post:: (Boolean) -- Variable to determine if the request is by 'post' or 'get' functions.
  #
  # ==== First Example
  #     @data = @mints_user.get_deals
  #
  # ==== Second Example
  #     options = { fields: 'id, title' }
  #     @data = @mints_user.get_deals(options)
  #
  # ==== Third Example
  #     options = { fields: 'id, title' }
  #     @data = @mints_user.get_deals(options, false)
  def get_deals(options = nil, use_post = true)
    get_query_results('/crm/deals', options, use_post)
  end

  # === Get deal.
  # Get a deal info.
  #
  # ==== Parameters
  # id:: (Integer) -- Deal id.
  # options:: (Hash) -- List of Resource Collection Options shown above can be used as parameter.
  #
  # ==== First Example
  #     @data = @mints_user.get_deal(1)
  #
  # ==== Second Example
  #     options = { fields: 'id, title' }
  #     @data = @mints_user.get_deal(1, options)
  def get_deal(id, options = nil)
    @client.raw('get', "/crm/deals/#{id}", options)
  end

  # === Create deal.
  # Create a deal with data.
  #
  # ==== Parameters
  # data:: (Hash) -- Data to be submitted.
  #
  # ==== Example
  #     data = {
  #       dealData: {
  #         title: 'New deal',
  #         stepId: 1,
  #         value: 10500
  #       }
  #     }
  #     @data = @mints_user.create_deal(data.to_json)
  def create_deal(data, options = nil)
    @client.raw('post', '/crm/deals', options, data_transform(data))
  end

  # === Update deal.
  # Update a deal data.
  #
  # ==== Parameters
  # id:: (Integer) -- Deal id.
  # data:: (Hash) -- Data to be submitted.
  #
  # ==== Example
  #     data = {
  #       title: 'New Deal Modified'
  #     }
  #     @data = @mints_user.update_deal(102, data.to_json)
  def update_deal(id, data, options = nil)
    @client.raw('put', "/crm/deals/#{id}", options, data_transform(data))
  end
end
