# frozen_string_literal: true

require_relative './item_prices'
require_relative './locations'
require_relative './order_items_groups'
require_relative './order_statuses'
require_relative './orders'
require_relative './price_lists'
require_relative './product_templates'
require_relative './product_variations'
require_relative './products'
require_relative './product_versions'
require_relative './skus'
require_relative './taxes'
require_relative './variant_options'
require_relative './variant_values'
require_relative './vouchers'

module Ecommerce
  include ItemPrices
  include Locations
  include OrderItemsGroups
  include OrderStatuses
  include Orders
  include PriceList
  include ProductTemplates
  include ProductVariations
  include Products
  include ProductVersions
  include Skus
  include Taxes
  include VariantOptions
  include VariantValues
  include Vouchers
end
