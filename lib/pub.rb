# frozen_string_literal: true

require 'yaml'
require_relative './client'
require_relative './mints/helpers/mints_helper'

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
  # * +taxonomies+ - [_Boolean_] If present, taxonomies will be returned for each record in the results. _Example:_
  #     { "taxonomies": true }
  # * +tags+ - [_Boolean_] If present, tags will be returned for each record in the results. _Example:_
  #     { "tags": true }
  # * +fields+ - [_String_] Specify the fields that you want to be returned. If empty, all fields are returned. The object index can also be used to specify specific fields from relations. _Example:_
  #     { fields: "id, title, slug" }
  #     { "fields[products]": "id, title, slug" }
  #
  # == Resource collections options
  # * +search+ - [_String_] If present, it will search for records matching the search string. _Example:_
  #     { "search": "search string" }
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
  #           slug:"title",
  #           "value":"Action movies"
  #         }
  #       ],
  #       "operator":"or"
  #     }
  #     options = { "jfilters": jfilter }
  # * +sort+ - [_String_] The name of the field to perform the sort. Prefix the value with a minus sign - for ascending order. _Example:_
  #     { sort: "title" }
  #     { sort: "-title" }

  class Pub
    attr_reader :client

    include MintsHelper

    ##
    # === Initialize.
    # Class constructor.
    #
    # ==== Parameters
    # host:: (String) -- It's the visitor IP.
    # api_key:: (String) -- Mints instance api key.
    # contact_token_id:: (Integer) --  Cookie 'mints_contact_id' value (mints_contact_token).
    #
    # ==== Return
    # Returns a Client object.
    def initialize(host, api_key, contact_token_id = nil, visit_id = nil, debug = false)
      @client = Mints::Client.new(host, api_key, 'public', nil, contact_token_id, visit_id, debug)
    end

    ##
    # === Register Visit.
    # Register a ghost/contact visit in Mints.Cloud.
    #
    # ==== Parameters
    # request:: (ActionDispatch::Request) -- request.
    # ip:: (String) -- It's the visitor IP.
    # user_agent:: (String) -- The visitor's browser user agent.
    # url:: (String) -- URL visited.
    #
    # ==== Example
    #     request = {
    #       "remote_ip" => "http://1.1.1.1/",
    #       "user_agent" => "User Agent",
    #       "fullpath" => "https://fullpath/example"
    #     }
    #     @data = @mints_pub.register_visit(request, request["remote_ip"], request["user_agent"], request["fullpath"])
    def register_visit(request, ip = nil, user_agent = nil, url = nil)
      data = {
        ip_address: ip || request.remote_ip,
        user_agent: user_agent || request.user_agent,
        url: url || request.fullpath
      }

      @client.raw('post', '/register-visit', nil, data.to_json)
    end

    ##
    # === Register Visit timer.
    # Register a page visit time.
    #
    # ==== Parameters
    # visit:: (String) -- It's the visitor IP.
    # time:: (Integer) -- The visitor's browser user agent.
    #
    # ==== Example
    #     @data = @mints_pub.register_visit_timer("60da2325d29acc7e55684472", 4)
    def register_visit_timer(visit, time)
      @client.raw('get', "/register-visit-timer?visit=#{visit}&time=#{time}")
    end

    ### V1/CONTENT ###

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

    ##
    # === Get Stories.
    # Get a collection of stories.
    #
    # ==== Parameters
    # options:: (Hash) -- List of {Resource collection Options}[#class-Mints::Pub-label-Resource+collections+options+] shown above can be used as parameter.
    # use_post:: (Boolean) -- Variable to determine if the request is by 'post' or 'get' functions.
    #
    # ==== First Example
    #     @data = @mints_pub.get_stories
    #
    # ==== Second Example
    #     options = { fields: 'id, slug' }
    #     @data = @mints_pub.get_stories(options)
    #
    # ==== Third Example
    #     options = {
    #       fields: 'id, slug'
    #     }
    #     @data = @mints_pub.get_stories(options, false)
    def get_stories(options = nil, use_post = true)
      get_query_results('/content/stories', options, use_post)
    end

    ##
    # === Get Story.
    # Get a single story.
    #
    # ==== Parameters
    # slug:: (String) -- It's the string identifier generated by Mints.
    # options:: (Hash) -- List of {Single Resource Options}[#class-Mints::Pub-label-Single+resource+options] shown above can be used as parameter.
    #
    # ==== First Example
    #     @data = @mints_pub.get_story("story_slug")
    #
    # ==== Second Example
    #     @data = @mints_pub.get_story("story_slug", options.to_json)
    def get_story(slug, options = nil)
      @client.raw('get', "/content/stories/#{slug}", options)
    end

    ##
    # === Get Story Versions.
    # Get a collection of story version.
    #
    # ==== Parameters
    # options:: (Hash) -- List of {Resource collection Options}[#class-Mints::Pub-label-Resource+collections+options+] shown above can be used as parameter.
    # use_post:: (Boolean) -- Variable to determine if the request is by 'post' or 'get' functions.
    #
    # ==== First Example
    #     @data = @mints_pub.get_story_versions
    #
    # ==== Second Example
    #     options = {
    #       fields: 'id, title'
    #     }
    #     @data = @mints_pub.get_story_versions(options)
    #
    # ==== Third Example
    #     options = {
    #       fields: 'id, title'
    #     }
    #     @data = @mints_pub.get_story_versions(options, false)
    def get_story_versions(options = nil, use_post = true)
      get_query_results('/content/story-versions', options, use_post)
    end

    ##
    # === Get Story Version.
    # Get a single story version.
    #
    # ==== Parameters
    # slug:: (String) -- It's the string identifier generated by Mints.
    # options:: (Hash) -- List of {Single Resource Options}[#class-Mints::Pub-label-Single+resource+options] shown above can be used as parameter.
    #
    # ==== First Example
    #     @data = @mints_pub.get_story_version("story_slug")
    #
    # ==== Second Example
    #     @data = @mints_pub.get_story_version("story_slug", options.to_json)
    def get_story_version(slug, options = nil)
      @client.raw('get', "/content/story-versions/#{slug}", options)
    end

    ##
    # === Get Forms.
    # Get a collection of forms.
    #
    # ==== Example
    #     @data = @mints_pub.get_forms
    def get_forms(options = nil)
      @client.raw('get', '/content/forms', options)
    end

    ##
    # === Get Form.
    # Get a single form.
    #
    # ==== Parameters
    # slug:: (String) -- It's the string identifier generated by Mints.
    #
    # ==== Example
    #     @data = @mints_pub.get_form("form_slug")
    def get_form(slug, options = nil)
      @client.raw('get', "/content/forms/#{slug}", options)
    end

    ##
    # === Submit Form.
    # Submit a form with data.
    #
    # ==== Parameters
    # data:: (Hash) -- Data to be submitted.
    #
    # ==== Example
    #     data = {
    #       'form_slug': 'form_slug',
    #       'email': 'email@example.com',
    #       'given_name': 'given_name',
    #       'f1': 'Field 1 answer',
    #       'f2': 'Field 2 answer',
    #       'f3': 'Field 3 answer'
    #     }
    #     @data = @mints_pub.submit_form(data)
    def submit_form(data)
      @client.raw('post', '/content/forms/submit', nil, data_transform(data))
    end

    ##
    # === Get Content Instances.
    # Get a collection of content instances. _Note:_ Options must be specified.
    #
    # ==== Parameters
    # options:: (Hash) -- List of {Resource collection Options}[#class-Mints::Pub-label-Resource+collections+options+] shown above can be used as parameter.
    #
    # ==== First Example
    #     options = {
    #       "template": "content_instance_template_slug"
    #     }
    #     @data = @mints_pub.get_content_instances(options)
    #
    # ==== Second Example
    #     options = {
    #       "template": "content_instance_template_slug",
    #       sort: "-id"
    #     }
    #     @data = @mints_pub.get_content_instances(options)
    def get_content_instances(options = nil)
      @client.raw('get', '/content/content-instances', options)
    end

    ##
    # === Get Content Instance.
    # Get a single content instance.
    #
    # ==== Parameters
    # slug:: (String) -- It's the string identifier generated by Mints.
    #
    # ==== Example
    #     @data = @mints_pub.get_content_instance("content_instance_slug")
    def get_content_instance(slug)
      @client.raw('get', "/content/content-instances/#{slug}")
    end

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

    ### V1/ECOMMERCE ###

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

    ##
    # === Get Products.
    # Get a collection of products.
    #
    # ==== Parameters
    # options:: (Hash) -- List of {Resource collection Options}[#class-Mints::Pub-label-Resource+collections+options+] shown above can be used as parameter.
    # use_post:: (Boolean) -- Variable to determine if the request is by 'post' or 'get' functions.
    #
    # ==== First Example
    #     @data = @mints_pub.get_products
    #
    # ==== Second Example
    #     options = { fields: "title" }
    #     @data = @mints_pub.get_products(options)
    #
    # ==== Third Example
    #     options = { fields: "title" }
    #     @data = @mints_pub.get_products(options, false)
    def get_products(options = nil, use_post = true)
      get_query_results('/ecommerce/products', options, use_post)
    end

    ##
    # === Get Product.
    # Get a single product.
    #
    # ==== Parameters
    # slug:: (String) -- It's the string identifier generated by Mints.
    # options:: (Hash) -- List of {Single Resource Options}[#class-Mints::Pub-label-Single+resource+options] shown above can be used as parameter.
    #
    # ==== First Example
    #     @data = @mints_pub.get_product("product_slug")
    #
    # ==== Second Example
    #     options = {
    #       fields: 'id, slug'
    #     }
    #     @data = @mints_pub.get_product("lego-set", options)
    def get_product(slug, options = nil)
      @client.raw('get', "/ecommerce/products/#{slug}", options)
    end

    ### V1/CONFIG ###

    ##
    # === Get Public Folders.
    # Get a collection of public folders.
    #
    # ==== Parameters
    # options:: (Hash) -- List of {Single Resource Options}[#class-Mints::Pub-label-Single+resource+options] shown above can be used as parameter.
    #
    # ==== First Example
    #     options = {
    #       object_type: "products"
    #     }
    #     @data = @mints_pub.get_public_folders(options)
    #
    # ==== Second Example
    #     options = {
    #       object_type: "products",
    #       fields: "id",
    #       sort: "-id"
    #     }
    #     @data = @mints_pub.get_public_folders(options)
    def get_public_folders(options = nil)
      @client.raw('get', '/config/public-folders', options)
    end

    ##
    # === Get Public Folder.
    # Get a public folder info.
    #
    # ==== Parameters
    # slug:: (String) -- It's the string identifier generated by Mints.
    # options:: (Hash) -- List of {Single Resource Options}[#class-Mints::Pub-label-Single+resource+options] shown above can be used as parameter.
    #
    # ==== First Example
    #     options = {
    #       object_type: "products"
    #     }
    #     @data = @mints_pub.get_public_folder('yellow', options)
    #
    # ==== Second Example
    #     options = {
    #       object_type: "products",
    #       fields: 'id, title'
    #     }
    #     @data = @mints_pub.get_public_folder('yellow', options)
    def get_public_folder(slug, options)
      @client.raw('get', "/config/public-folders/#{slug}", options)
    end

    ##
    # === Get Tags.
    # Get a collection of tags.
    #
    # ==== Parameters
    # options:: (Hash) -- List of {Resource collection Options}[#class-Mints::Pub-label-Resource+collections+options+] shown above can be used as parameter.
    #
    # ==== First Example
    #     @data = @mints_pub.get_tags
    #
    # ==== Second Example
    #     options = {
    #       fields: "id, tag"
    #     }
    #     @data = @mints_pub.get_tags(options)
    def get_tags(options = nil)
      @client.raw('get', '/config/tags', options)
    end

    ##
    # === Get Tag.
    # Get a single tag.
    #
    # ==== Parameters
    # slug:: (String) -- It's the string identifier generated by Mints.
    # options:: (Hash) -- List of {Single Resource Options}[#class-Mints::Pub-label-Single+resource+options] shown above can be used as parameter.
    #
    # ==== First Example
    #     @data = @mints_pub.get_tag("tag_slug")
    #
    # ==== Second Example
    #     options = {
    #       fields: "id, tag"
    #     }
    #     @data = @mints_pub.get_tag("tag-example", options)
    def get_tag(slug, options = nil)
      @client.raw('get', "/config/tags/#{slug}", options)
    end

    ##
    # === Get Taxonomies.
    # Get a collection of taxonomies.
    #
    # ==== Parameters
    # options:: (Hash) -- List of {Resource collection Options}[#class-Mints::Pub-label-Resource+collections+options+] shown above can be used as parameter.
    # use_post:: (Boolean) -- Variable to determine if the request is by 'post' or 'get' functions.
    #
    # ==== First Example
    #     @data = @mints_pub.get_taxonomies
    #
    # ==== Second Example
    #     options = {
    #       fields: 'id, title'
    #     }
    #     @data = @mints_pub.get_taxonomies(options)
    #
    # ==== Third Example
    #     options = {
    #       fields: 'id, title'
    #     }
    #     @data = @mints_pub.get_taxonomies(options, false)
    def get_taxonomies(options = nil, use_post = true)
      get_query_results('/config/taxonomies', options, use_post)
    end

    ##
    # === Get Taxonomy.
    # Get a single taxonomy.
    #
    # ==== Parameters
    # slug:: (String) -- It's the string identifier generated by Mints.
    # options:: (Hash) -- List of {Single Resource Options}[#class-Mints::Pub-label-Single+resource+options] shown above can be used as parameter.
    #
    # ==== First Example
    #     @data = @mints_pub.get_taxonomy('taxonomy_slug')
    #
    # ==== Second Example
    #     options = {
    #       fields: 'title'
    #     }
    #     @data = @mints_pub.get_taxonomy('taxonomy_slug', options)
    def get_taxonomy(slug, options = nil)
      @client.raw('get', "/config/taxonomies/#{slug}", options)
    end

    ##
    # === Get Attributes.
    # Get a collection of attributes.
    #
    # ==== Example
    #     @data = @mints_pub.get_attributes
    def get_attributes
      @client.raw('get', '/config/attributes')
    end

    def send_user_magic_link(email_or_phone, template_slug, redirect_url = '', life_time = 1440, max_visits = nil, driver = 'email')
      data = {
        driver: driver,
        lifeTime: life_time,
        maxVisits: max_visits,
        redirectUrl: redirect_url,
        templateId: template_slug
      }

      key = %w[sms whatsapp].include? driver ? 'phone' : 'email'
      data[key] = email_or_phone
      @client.raw('post', '/users/magic-link', nil, { data: data }.to_json, '/api/v1')
    end
  end
end
