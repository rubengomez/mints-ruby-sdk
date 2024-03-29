# frozen_string_literal: true

module PublicContentBundles
  ##
  # === Get Content Pages.
  # Get all content pages.
  #
  # ==== Parameters
  # options:: (Hash) -- List of {Resource collection Options}[#class-Mints::Pub-label-Resource+collections+options+] shown above can be used as parameter.
  def get_content_bundles(options = nil)
    @client.raw('get', '/content/content-bundles', options)
  end

  ##
  # === Get Content Page.
  # Get a single content page.
  #
  # ==== Parameters
  # slug:: (String) -- It's the string identifier generated by Mints.
  #
  # ==== Example
  #     @data = @mints_pub.get_content_page("test-page")
  def get_content_page(slug, options = nil)
    warn '[DEPRECATED] The get_content_page method is deprecated and will be removed in the future, use get_content_bundle instead'
    @client.raw('get', "/content/content-pages/#{slug}", options)
  end

  ##
  # === Get Content Bundle.
  # Get a single content bundle.
  #
  # ==== Parameters
  # slug:: (String) -- It's the string identifier generated by Mints.
  #
  # ==== Example
  #     @data = @mints_pub.get_content_bundle("test-page")
  def get_content_bundle(slug, options = nil)
    @client.raw('get', "/content/content-bundles/#{slug}", options)
  end
end
