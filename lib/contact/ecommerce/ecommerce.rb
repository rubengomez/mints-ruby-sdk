# frozen_string_literal: true

require_relative './order_items_groups'
require_relative './order_items'
require_relative './orders'
require_relative './vouchers'

module ContactEcommerce
  include ContactOrderItemsGroups
  include ContactOrderItems
  include ContactOrders
  include ContactVouchers

end
