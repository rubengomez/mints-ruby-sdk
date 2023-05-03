# frozen_string_literal: true

module PublicLocations
  ##
  # === Get Locations.
  # Get all locations.
  #
  # ==== Parameters
  # options:: (Hash) -- List of {Resource collection Options}[#class-Mints::Pub-label-Resource+collections+options+] shown above can be used as parameter.
  # use_post:: (Boolean) -- Variable to determine if the request is by 'post' or 'get' functions.
  #
  # ==== First Example
  #     @data = @mints_pub.get_locations
  #
  # ==== Second Example
  #     options = { fields: "title" }
  #     @data = @mints_pub.get_locations(options)
  #
  # ==== Third Example
  #     options = { fields: "title" }
  #     @data = @mints_pub.get_locations(options, false)
  def get_locations(options = nil, use_post = true)
    get_query_results('/ecommerce/locations', options, use_post)
  end
end
