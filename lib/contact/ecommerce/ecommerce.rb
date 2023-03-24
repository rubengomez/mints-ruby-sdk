# frozen_string_literal: true

require_relative './order_items_groups'
require_relative './order_items'
require_relative './orders'

module Ecommerce
  include OrderItemsGroups
  include OrderItems
  include Orders

end
