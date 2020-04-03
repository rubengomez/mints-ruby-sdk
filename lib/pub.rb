require_relative './client.rb'
module Mints
  class Pub
    attr_reader :client
    def initialize(host, api_key)
      @client = Mints::Client.new(host, api_key)
    end
    
    def register_visit(ip, user_agent, url)
      data = {
        ip_address: ip,
        user_agent: user_agent,
        url: url
      }
      return @client.raw("post", "/register-visit-timer", nil, data)
    end

    def register_visit_timer
      return @client.raw("get", "/register-visit-timer")
    end

    def get_content_page(slug, options = nil)
      return @client.raw("get", "/content-pages/#{slug}", options)
    end

    def get_content_templates(options = nil)
      return @client.raw("get", "/content/content-templates")
    end

    def get_content_template(slug, options = nil)
      return @client.raw("get", "/content/content-templates/#{slug}", options)
    end

    def content_instances(options) 
      return @client.raw("get", "/content/content-instances", options)
    end

    def content_instance(slug, options = nil)
      return @client.raw("get", "/content/content-instances/#{slug}", options)
    end

    def get_stories(options = nil)
      return @client.raw("get", "/content/stories", options)
    end

    def get_story(slug, options = nil)

      return @client.raw("get", "/content/stories/#{slug}", options)
    end

    def get_forms(options = nil)
      return @client.raw("get", "/content/forms/{slug}", options)
    end

    def get_form(slug, options = nil)
      return @client.raw("get", "/content/forms/{slug}", options)
    end

    def submit_form(data)
      return @client.raw("post", "/forms/store", nil, data)
    end

    def get_products(options = nil)
      return @client.raw("get", "/ecommerce/products", options)
    end

    def get_product(slug, options = nil)
      return @client.raw("get", "/ecommerce/products/#{slug}", options)
    end

    def get_product_brands(options = nil)
      return @client.raw("get", "/ecommerce/product-brands", options)
    end

    def get_product_brand(slug, options = nil)
      return @client.raw("get", "/ecommerce/product-brands/#{slug}", options)
    end

    def get_skus(options = nil)
      return @client.raw("get", "/ecommerce/skus", options)
    end

    def get_sku(slug, options = nil)
      return @client.raw("get", "/ecommerce/skus/#{slug}", options)
    end
    
    def get_categories(options = nil)
      return @client.raw("get", "/config/categories", options)
    end

    def get_category(slug, options = nil)
      return @client.raw("get", "/config/categories/#{slug}", options)
    end

    def get_tags(options)
      return @client.raw("get", "/config/tags", options)
    end

    def get_tag(slug, options = nil)
      return @client.raw("get", "/config/tags/#{slug}", options)
    end

    def get_attributes(options = nil)
      return @client.raw("get", "/config/attributes", options)
    end
  end
end
