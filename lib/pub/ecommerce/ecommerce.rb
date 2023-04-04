# frozen_string_literal: true

### V1/ECOMMERCE ###

require_relative './locations'
require_relative './products'
require_relative './orders'

module PublicEcommerce
  include PublicLocations
  include PublicProducts
  include PublicOrders

end
