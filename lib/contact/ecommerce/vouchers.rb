# frozen_string_literal: true

module Vouchers
  ##
  # === Apply voucher.
  # Apply voucher code to the existing order, only applies to sale orders.
  #
  # ==== Parameters
  # order_id:: (Integer) -- Order id.
  # data:: (Hash) -- Data to be submitted.
  #
  # ==== Example
  #     data = { description: 'This is the transaction description', voucher_code: 'XAZWQ12MP' }
  #     @data = @mints_contact.apply_voucher(1, data)
  def apply_voucher(order_id, data)
    @client.raw('post', "/ecommerce/orders/#{order_id}/voucher", nil, data_transform(data))
  end
end
