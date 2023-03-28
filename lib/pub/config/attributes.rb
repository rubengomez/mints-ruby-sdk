# frozen_string_literal: true

module Attributes
  ##
  # === Get Attributes.
  # Get a collection of attributes.
  #
  # ==== Example
  #     @data = @mints_pub.get_attributes
  def get_attributes
    @client.raw('get', '/config/attributes')
  end
end
