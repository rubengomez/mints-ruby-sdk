# frozen_string_literal: true

module Vouchers
  ##
  # === Get vouchers.
  # Get a collection of vouchers.
  #
  # ==== Parameters
  # options:: (Hash) -- List of Resource Collection Options shown above can be used as parameter.
  # use_post:: (Boolean) -- Variable to determine if the request is by 'post' or 'get' functions.
  #
  # ==== First Example
  #
  #     @data = @mints_user.get_vouchers
  # ==== Second Example
  #
  #     options = { fields: 'id,title' }
  #     @data = @mints_user.get_vouchers(options)
  # ==== Third Example
  #
  #     options = { fields: 'id,title' }
  #     @data = @mints_user.get_vouchers(options, true)
  #
  def get_vouchers(options = nil, use_post = true)
    get_query_results('/ecommerce/vouchers', options, use_post)
  end

  ##
  # === Get vouchers.
  # Get a specific voucher.
  #
  # ==== Parameters
  # id:: (Integer) -- Voucher id.
  # options:: (Hash) -- List of Resource Collection Options shown above can be used as parameter.
  #
  # ==== First Example
  #
  #     @data = @mints_user.get_voucher(1)
  # ==== Second Example
  #
  #     options = { fields: 'id,title' }
  #     @data = @mints_user.get_voucher(1, options)
  def get_voucher(id, options = nil)
    @client.raw('get', "/ecommerce/vouchers/#{id}", options)
  end

  ##
  # === Create voucher.
  # Create voucher code.
  #
  # ==== Parameters
  # data:: (Hash) -- Data to be submitted.
  #
  # ==== Example
  #     data = {
  #       title: 'Voucher title',
  #       voucher_code: 'XAZWQ12MP',
  #       amount: 100,
  #       start_date: '2023-03-28T10:20:00-06:00',
  #       end_date: '2023-03-31T10:20:00-06:00',
  #       is_redeemed: false
  #     }
  #
  #     @data = @mints_user.create_voucher(data)
  def create_voucher(data)
    @client.raw('post', '/ecommerce/vouchers', nil, data_transform(data))
  end

  ##
  # === Update voucher.
  # Update voucher code.
  #
  # ==== Parameters
  # id:: (Integer) -- Voucher id.
  # data:: (Hash) -- Data to be submitted.
  #
  # ==== Example
  #     data = {
  #       title: 'New voucher title',
  #       voucher_code: 'XAZWQ12MP2',
  #       amount: 250,
  #       start_date: '2023-03-27T10:20:00-06:00',
  #       end_date: '2023-03-30T10:20:00-06:00'
  #     }
  #
  #     @data = @mints_user.update_voucher(1, data)
  def update_voucher(id, data)
    @client.raw('put', "/ecommerce/vouchers/#{id}", nil, data_transform(data))
  end
end
