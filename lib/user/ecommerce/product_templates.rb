# frozen_string_literal: true

module ProductTemplates
  ##
  # == Product Templates
  #

  # === Get product templates support data from product.
  # Get product templates support data from a product.
  #
  # ==== Parameters
  # id:: (Integer) -- Product id.
  #
  # ==== Example
  #     @data = @mints_user.get_product_templates_support_data_from_product(1)
  def get_product_templates_support_data_from_product(id)
    @client.raw('get', "/ecommerce/product-templates/support-data/products/#{id}")
  end

  # === Get product templates support data from order items group.
  # Get product templates support data from a order items group.
  #
  # ==== Parameters
  # id:: (Integer) -- Order items group id.
  #
  # ==== Example
  #     @data = @mints_user.get_product_templates_support_data_from_order_items_group(1)
  def get_product_templates_support_data_from_order_items_group(id)
    @client.raw('get', "/ecommerce/product-templates/support-data/order-items-groups/#{id}")
  end

  # === Get product templates support data.
  # Get support data used in product templates.
  #
  # ==== Example
  #     @data = @mints_user.get_product_templates_support_data
  def get_product_templates_support_data
    @client.raw('get', '/ecommerce/product-templates/support-data')
  end

  # === Get product templates.
  # Get a collection of product templates.
  #
  # ==== Parameters
  # options:: (Hash) -- List of Resource Collection Options shown above can be used as parameter.
  #
  # ==== First Example
  #     @data = @mints_user.get_product_templates
  #
  # ==== Second Example
  #     options = { fields: 'title' }
  #     @data = @mints_user.get_product_templates(options)
  def get_product_templates(options = nil)
    @client.raw('get', '/ecommerce/product-templates', options)
  end

  # === Get product template.
  # Get a product template info.
  #
  # ==== Parameters
  # id:: (Integer) -- Product template id.
  # options:: (Hash) -- List of Resource Collection Options shown above can be used as parameter.
  #
  # ==== First Example
  #     @data = @mints_user.get_product_template(1)
  #
  # ==== Second Example
  #     options = { fields: 'title' }
  #     @data = @mints_user.get_product_template(1, options)
  def get_product_template(id, options = nil)
    @client.raw('get', "/ecommerce/product-templates/#{id}", options)
  end

  # === Create product template.
  # Create a product template with data.
  #
  # ==== Parameters
  # data:: (Hash) -- Data to be submitted.
  #
  # ==== Example
  #     data = {
  #       title: 'New Product Template',
  #       slug: 'new-product-template'
  #     }
  #     @data = @mints_user.create_product_template(data)
  def create_product_template(data)
    @client.raw('post', '/ecommerce/product-templates/', nil, data_transform(data))
  end

  # === Update product template.
  # Update a product template info.
  #
  # ==== Parameters
  # id:: (Integer) -- Product template id.
  # data:: (Hash) -- Data to be submitted.
  #
  # ==== Example
  #     data = {
  #       title: 'New Product Template Modified',
  #       slug: 'new-product-template'
  #     }
  #     @data = @mints_user.update_product_template(3, data)
  def update_product_template(id, data)
    @client.raw('put', "/ecommerce/product-templates/#{id}", nil, data_transform(data))
  end
end
