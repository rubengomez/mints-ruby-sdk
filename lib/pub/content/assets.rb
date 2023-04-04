# frozen_string_literal: true

module PublicAssets
  ##
  # === Get Asset Info.
  # Get a description of an Asset.
  #
  # ==== Parameters
  # slug:: (String) -- It's the string identifier of the asset.
  #
  # ==== Example
  #     @data = @mints_pub.get_asset_info("asset_slug")
  def get_asset_info(slug)
    @client.raw('get', "/content/asset-info/#{slug}")
  end
end
