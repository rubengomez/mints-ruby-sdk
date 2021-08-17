require 'yaml'
require_relative './client.rb'
module Mints
  ##
  # == Public context API
  # Pub class contains functions that needs only an API key as authentication
  # == Usage example
  # === For Mints::BaseController inheritance:
  # If the controller is inheriting from Mints::BaseController, Only use the class variable *mints_pub*  _Example:_
  #     @mints_pub.get_stories
  # === For standalone usage:
  # Initialize
  #     pub = Mints::Pub.new(mints_url, api_key)
  # or if host and api_key are provided by mints_config.yml.erb
  #     pub = Mints::Pub.new
  # Call any function
  #     pub.get_products
  # == Single resource options
  # * +include+ - [_String_] Specify additional information to be included in the results from the objects relations. _Example:_
  #     { "include": "events" }
  # * +attributes+ - [_Boolean_] If present, attributes will be returned for each record in the results. _Example:_
  #     { "attributes": true }
  # * +categories+ - [_Boolean_] If present, categories will be returned for each record in the results. _Example:_
  #     { "categories": true }
  # * +tags+ - [_Boolean_] If present, tags will be returned for each record in the results. _Example:_
  #     { "tags": true }
  # * +fields+ - [_String_] Specify the fields that you want to be returned. If empty, all fields are returned. The object index can also be used to specify specific fields from relations. _Example:_
  #     { "fields": "id, title, slug" }
  #     { "fields[products]": "id, title, slug" }
  #
  # == Resource collections options 
  # * +search+ - [_String_] If present, it will search for records matching the search string. _Example:_
  #     { "search": "searchstring" }
  # * +scopes+ - [_String_] If present, it will apply the specified Model's scopes. _Example:_
  #     { "scopes": "approved, recent" }
  # * +filters+ - [_String_] This is a powerful parameter that allows the data to be filtered by any of its fields. Currently only exact matches are supported. _Example:_
  #     { "filters[title]": "titleToFilter" }
  # * +jfilters+ - [_String_] A complex filter configuration, as used in segments, in JSON format, base64 encoded and URLencoded. _Example:_
  #     jfilter = {
  #       "type":"group",
  #       "items":[
  #         {
  #           "type":"attribute",
  #           "operator":"==",
  #           "slug":"title",
  #           "value":"Action movies"
  #         }
  #       ],
  #       "operator":"or"
  #     } 
  #     options = { "jfilters": jfilter }
  # * +catfilters+ - [_String_] filter by categories. _Example:_
  #     { "catfilters": "categoryName" }
  # * +fields+ - [_String_] Specify the fields that you want to be returned. If empty, all fields are returned. The object index can also be used to specify specific fields from relations. _Example:_
  #     { "fields": "id, title, slug" }
  #     { "fields[products]": "id, title, slug" }
  # * +sort+ - [_String_] The name of the field to perform the sort. Prefix the value with a minus sign - for ascending order. _Example:_
  #     { "sort": "title" }
  #     { "sort": "-title" }
  # * +include+ - [_String_] Specify additional information to be included in the results from the objects relations. _Example:_
  #     { "include": "events" }
  # * +attributes+ - [_Boolean_] If present, attributes will be returned for each record in the results. _Example:_
  #     { "attributes": true }
  # * +categories+ - [_Boolean_] If present, categories will be returned for each record in the results. _Example:_
  #     { "categories": true }
  # * +taxonomies+ - [_Boolean_] If present, taxonomies will be returned for each record in the results. _Example:_
  #     { "taxonomies": true }
  # * +tags+ - [_Boolean_] If present, tags will be returned for each record in the results. _Example:_
  #     { "tags": true }

  class Pub
    attr_reader :client

    ##
    # === Initialize.
    # Class constructor
    #
    # ==== Parameters
    # * +host+ - [String] It's the visitor IP
    # * +api_key+ - [String] Mints instance api key
    # * +contact_token+ - [String] Cookie 'mints_contact_id' value (mints_contact_token)
    # ==== Return
    # Returns a Client object
    def initialize(host, api_key, contact_token_id = nil,  debug = false)
      @client = Mints::Client.new(host, api_key, 'public', nil, contact_token_id, debug)
    end
    
    ##
    # === Register Visit.
    # Register a ghost/contact visit in Mints.Cloud
    #
    # ==== Parameters
    # * +request+ - [ActionDispatch::Request] request
    # * +ip+ - [String] It's the visitor IP
    # * +user_agent+ - The visitor's browser user agent
    # * +url+ - [String] URL visited
    #
    # ==== Example
    #     request = {
    #       "remote_ip" => "http://864.401.156.12/",
    #       "user_agent" => "User Agent",
    #       "fullpath" => "https://mints.cloud/blog"
    #     }
    #     @datos = @mints_pub.register_visit(request, request["remote_ip"], request["user_agent"], request["fullpath"])
    #
    def register_visit(request, ip = nil, user_agent = nil, url = nil)
      data = {
        ip_address: ip || request.remote_ip,
        user_agent: user_agent || request.user_agent,
        url: url || request.fullpath
      }
      response = @client.raw("post", "/register-visit", nil, data.to_json)
      return response
    end

    ##
    # === Register Visit timer.
    # Register a page visit time
    #
    # ==== Parameters
    # * +visit+ - [String] It's the visitor IP
    # * +time+ - [Integer] The visitor's browser user agent
    #
    # ==== Example
    #     @datos = @mints_pub.register_visit_timer("60da2325d29acc7e55684472", 4)
    #
    def register_visit_timer(visit, time)
      return @client.raw("get", "/register-visit-timer?visit=#{visit}&time=#{time}")
    end

    ##
    # === Get Asset Info.
    # Get a description of an Asset
    #
    # ==== Parameters
    # * +slug+ - [String] It's the string identifier of the asset.
    #
    # ==== Example
    #     @datos = @mints_pub.get_asset_info("quaerat")
    #
    def get_asset_info(slug)
      return @client.raw("get", "/content/asset-info/#{slug}")
    end
    
    ##
    # === Get Stories.
    # Get a collection of stories
    #
    # ==== Parameters
    # * +options+ - [Hash] List of {Resource collection Options}[#class-Mints::Pub-label-Resource+collections+options+] shown above can be used as parameter
    #
    # ==== Example
    #     @datos = @mints_pub.get_stories
    #
    def get_stories(options = nil)
      return @client.raw("get", "/content/stories", options)
    end

    ##
    # === Get Story.
    # Get a single story.
    #
    # ==== Parameters
    # * +slug+ - [String] It's the string identifier generated by Mints
    # * +options+ - [Hash] List of {Single Resource Options}[#class-Mints::Pub-label-Single+resource+options] shown above can be used as parameter
    #
    # ==== Example
    #     @datos = @mints_pub.get_story("getting-ready-for-e3")
    #
    def get_story(slug, options = nil)
      return @client.raw("get", "/content/stories/#{slug}", options)
    end

    ##
    # === Get Forms.
    # Get a collection of forms
    #
    # ==== Parameters
    # * +options+ - [Hash] List of {Resource collection Options}[#class-Mints::Pub-label-Resource+collections+options+] shown above can be used as parameter
    #
    # ==== Example
    #     @datos = @mints_pub.get_forms
    #
    def get_forms(options = nil)
      return @client.raw("get", "/content/forms", options)
    end

    ##
    # === Get Form.
    # Get a single form.
    #
    # ==== Parameters
    # * +slug+ - [String] It's the string identifier generated by Mints
    # * +options+ - [Hash] List of {Single Resource Options}[#class-Mints::Pub-label-Single+resource+options] shown above can be used as parameter
    #
    # ==== Example
    #     @datos = @mints_pub.get_form("survey")
    #
    def get_form(slug, options = nil)
      return @client.raw("get", "/content/forms/#{slug}", options)
    end

    ##
    # === Submit Form.
    # Submit a form.
    #
    # ==== Parameters
    # * +data+ - [Hash] Data to be submited
    #
    # ==== Example
    #     data_form = {
    #       "data": {
    #         'form_slug': 'formulario',
    #         'email': 'oscar@mints.cloud',
    #         'ingrese-un-texto': 'hola'
    #       }
    #     }
    #     @datos1 = @mints_pub.submit_form(data_form.to_json)
    #
    def submit_form(data)
      return @client.raw("post", "/content/forms/submit", nil, data)
    end    

    ##
    # === Get Content Instances.
    # Get a collection of content instances. _Note:_ Options must be specified. 
    #
    # ==== Parameters
    # * +options+ - [Hash] List of {Resource collection Options}[#class-Mints::Pub-label-Resource+collections+options+] shown above can be used as parameter
    def get_content_instances(options = nil) 
      return @client.raw("get", "/content/content-instances", options)
    end

    ##
    # === Get Content Instance.
    # Get a single content instance.
    #
    # ==== Parameters
    # * +slug+ - [String] It's the string identifier generated by Mints
    # * +options+ - [Hash] List of {Single Resource Options}[#class-Mints::Pub-label-Single+resource+options] shown above can be used as parameter
    #
    # ==== Example
    #     @datos = @mints_pub.get_content_instance("bill-gates")
    #
    def get_content_instance(slug, options = nil)
      return @client.raw("get", "/content/content-instances/#{slug}", options)
    end

    ##
    # === Get Content Pages.
    # Get all content pages.
    #
    # ==== Parameters
    # * +options+ - [Hash] List of {Resource collection Options}[#class-Mints::Pub-label-Resource+collections+options+] shown above can be used as parameter
    def get_content_pages(options = nil)
      return @client.raw("get", "/content/content-pages", options)
    end

    ##
    # === Get Content Page.
    # Get a single content page
    #
    # ==== Parameters
    # * +slug+ - [String] It's the slug 
    # * +options+ - [Hash] List of {Single Resource Options}[#class-Mints::Pub-label-Single+resource+options] shown above can be used as parameter
    #
    # ==== Example
    #     @datos = @mints_pub.get_content_page("test-page")
    #
    def get_content_page(slug, options = nil)
      return @client.raw("get", "/content/content-pages/#{slug}", options)
    end

    ##
    # === Get Locations.
    # Get all locations.
    #
    # ==== Parameters
    # * +options+ - [Hash] List of {Resource collection Options}[#class-Mints::Pub-label-Resource+collections+options+] shown above can be used as parameter
    #
    # ==== Example
    #     @datos = @mints_pub.get_locations
    #
    def get_locations(options = nil)
      return @client.raw("get", "/ecommerce/locations", options)
    end

    ##
    # === Get Products.
    # Get a collection of products.
    #
    # ==== Parameters
    # * +options+ - [Hash] List of {Resource collection Options}[#class-Mints::Pub-label-Resource+collections+options+] shown above can be used as parameter
    #
    # ==== Example
    #     @datos = @mints_pub.get_products
    #
    def get_products(options = nil)
      return @client.raw("get", "/ecommerce/products", options)
    end

    ##
    # === Get Product.
    # Get a single product.
    #
    # ==== Parameters
    # * +slug+ - [String] It's the string identifier generated by Mints
    # * +options+ - [Hash] List of {Single Resource Options}[#class-Mints::Pub-label-Single+resource+options] shown above can be used as parameter
    #
    # ==== Example
    #     @datos = @mints_pub.get_product("batman-shirt")
    #
    def get_product(slug, options = nil)
      return @client.raw("get", "/ecommerce/products/#{slug}", options)
    end

    ##
    # === Get categories.
    # Get a collection of categories.
    #
    # ==== Parameters
    # * +options+ - [Hash] List of {Resource collection Options}[#class-Mints::Pub-label-Resource+collections+options+] shown above can be used as parameter
    #
    # ==== Example
    #     options = {
    #       "object_type": "stories"
    #     }
    #     @datos = @mints_pub.get_categories(options)
    def get_categories(options = nil)
      return @client.raw("get", "/config/categories", options)
    end

    ##
    # === Get Category.
    # Get a single category
    #
    # ==== Parameters
    # * +slug+ - [String] It's the string identifier generated by Mints
    # * +options+ - [Hash] List of {Single Resource Options}[#class-Mints::Pub-label-Single+resource+options] shown above can be used as parameter
    #
    # ==== Example
    #     options = {
    #       "object_type": "locations"
    #     }
    #     @datos = @mints_pub.get_category("atm", options)
    #
    def get_category(slug, options = nil)
      return @client.raw("get", "/config/categories/#{slug}", options)
    end

    ##
    # === Get Tags.
    # Get a collection of tags.
    #
    # ==== Parameters
    # * +options+ - [Hash] List of {Resource collection Options}[#class-Mints::Pub-label-Resource+collections+options+] shown above can be used as parameter
    #
    # ==== Example
    #     @datos = @mints_pub.get_tags
    #
    def get_tags(options = nil)
      return @client.raw("get", "/config/tags", options)
    end

    ##
    # === Get Tag.
    # Get a single tag
    #
    # ==== Parameters
    # * +slug+ - [String] It's the string identifier generated by Mints
    # * +options+ - [Hash] List of {Single Resource Options}[#class-Mints::Pub-label-Single+resource+options] shown above can be used as parameter
    #
    # ==== Example
    #     @datos = @mints_pub.get_tag("ad-0")
    #
    def get_tag(slug, options = nil)
      return @client.raw("get", "/config/tags/#{slug}", options)
    end

    ##
    # === Get Taxonomies.
    # Get a collection of taxonomies.
    #
    # ==== Parameters
    # * +options+ - [Hash] List of {Resource collection Options}[#class-Mints::Pub-label-Resource+collections+options+] shown above can be used as parameter
    #
    # ==== Example
    #     @datos = @mints_pub.get_taxonomies
    #
    def get_taxonomies(options = nil)
      return @client.raw("get", "/config/taxonomies", options)
    end

    ##
    # === Get Taxonomy.
    # Get a single taxonomy
    #
    # ==== Parameters
    # * +slug+ - [String] It's the string identifier generated by Mints
    # * +options+ - [Hash] List of {Single Resource Options}[#class-Mints::Pub-label-Single+resource+options] shown above can be used as parameter
    #
    # ==== Example
    #     @datos = @mints_pub.get_taxonomy("unit_pricing_measure")
    #
    def get_taxonomy(slug, options = nil)
      return @client.raw("get", "/config/taxonomies/#{slug}", options)
    end

    ##
    # === Get Attributes.
    # Get a collection of attributes.
    #
    # ==== Parameters
    # * +options+ - [Hash] List of {Resource collection Options}[#class-Mints::Pub-label-Resource+collections+options+] shown above can be used as parameter
    #
    # ==== Example
    #     @datos = @mints_pub.get_attributes
    #
    def get_attributes(options = nil)
      return @client.raw("get", "/config/attributes", options)
    end
  end
end
