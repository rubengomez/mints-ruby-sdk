# frozen_string_literal: true

require_relative './order_items_groups'
require_relative './order_items'
require_relative './orders'
require_relative './vouchers'

module Ecommerce
  include OrderItemsGroups
  include OrderItems
  include Orders
  include Vouchers

end
