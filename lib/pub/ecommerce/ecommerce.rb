# frozen_string_literal: true

### V1/ECOMMERCE ###

require_relative './locations'
require_relative './products'
require_relative './orders'

module Ecommerce
  include Locations
  include Products
  include Orders

end
