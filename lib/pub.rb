# frozen_string_literal: true

require 'yaml'
require_relative './client'
require_relative './mints/helpers/mints_helper'
require_relative './mints/helpers/threads_helper'
require_relative './pub/content/content'
require_relative './pub/ecommerce/ecommerce'
require_relative './pub/config/config'

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
    include PublicContent
    include PublicEcommerce
    include PublicConfig
    include ThreadsHelper

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
    def initialize(host, api_key, contact_token_id = nil, visit_id = nil, debug = false, timeouts = {})
      @client = Mints::Client.new(
        host,
        api_key,
        'public',
        nil,
        contact_token_id,
        visit_id,
        debug,
        timeouts
      )
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
