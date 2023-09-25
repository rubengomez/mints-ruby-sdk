# frozen_string_literal: true

### V1/ECOMMERCE ###

require_relative './locations'
require_relative './product_versions'
require_relative './orders'

module PublicEcommerce
  include PublicLocations
  include PublicProductVersions
  include PublicOrders

end
