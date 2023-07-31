# frozen_string_literal: true

require 'httparty'
require 'json'
require 'addressable'
require 'redis'

module Mints
  class Client

    attr_reader :host
    attr_reader :api_key
    attr_reader :scope
    attr_reader :base_url
    attr_accessor :session_token
    attr_accessor :contact_token_id

    def initialize(host, api_key, scope = nil, session_token = nil, contact_token_id = nil, visit_id = nil, debug = false)
      @host = host
      @api_key = api_key
      @session_token = session_token
      @contact_token_id = contact_token_id
      @visit_id = visit_id
      @debug = debug

      self.set_scope(scope)
    end

    def raw(action, url, options = nil, data = nil, base_url = nil, compatibility_options = {}, only_tracking = false)
      compatibility_options = {} if compatibility_options.nil?

      base_url = @base_url unless base_url
      uri = ''

      if options&.class == Hash
        need_encoding = %w[jfilters afilters rfilters]
        found_options_with_encoding = options.keys.select { |key| need_encoding.include?(key.to_s.downcase) and options[key]&.class == Hash }

        found_options_with_encoding.each do |key|
          options[key] = CGI::escape(Base64.encode64(options[key].to_json))
        end

        uri = Addressable::URI.new
        uri.query_values = options
      end

      full_url = "#{@host}#{base_url}#{url}#{uri}"
      response = nil

      template = ERB.new File.new("#{Rails.root}/mints_config.yml.erb").read
      config = YAML.safe_load template.result(binding)
      result_from_cache = false

      if action === 'get'
        url_need_cache = false

        if config['redis_cache']['use_cache']
          config['redis_cache']['groups'].each do |group|
            group['urls'].each do |url|
              if full_url.match url
                time = group['time']
                url_need_cache = true
                @redis_server = Redis.new(
                  host: config['redis_cache']['redis_host'],
                  port: config['redis_cache']['redis_port'] ? config['redis_cache']['redis_port'] : 6379,
                  db: config['redis_cache']['redis_db'] ? config['redis_cache']['redis_db'] : 1
                )
                redis_response = @redis_server.get(full_url)

                if redis_response
                  response = redis_response
                  result_from_cache = true

                  if only_tracking
                    # headers = { 'Only-Tracking' => 'true' }
                    #when is already in redis notify to California to register the object usage
                    #cali_response = self.send("#{@scope}_#{action}", full_url, headers, compatibility_options)
                  end
                else
                  response = self.send("#{@scope}_#{action}", full_url, nil, compatibility_options)
                  @redis_server.setex(full_url, time, response)
                end
                break
              end
            end

            break if url_need_cache
          end
        end

        unless url_need_cache
          response = self.send("#{@scope}_#{action}", full_url, nil, compatibility_options)
        end

      elsif action === 'create' or action === 'post'
        action = 'post'
        response = self.send("#{@scope}_#{action}", full_url, data, compatibility_options)
      elsif action === 'put' or action === 'patch' or action === 'update'
        action = 'put'
        response = self.send("#{@scope}_#{action}", full_url, data, compatibility_options)
      elsif action === 'delete' or action === 'destroy'
        action = 'delete'
        response = self.send("#{@scope}_#{action}", full_url, data, compatibility_options)
      end

      verify_response_status(response, config['sdk']['ignore_http_errors'])

      begin
        if result_from_cache
          if @debug
            puts "Method: #{action} \nURL: #{url} \nOptions: #{options&.to_json} \nOnly tracking: #{only_tracking} \nResponse from: REDIS"
            puts "Data: #{data.to_json}" if data
          end

          return JSON.parse(response)
        else

          if @debug
            puts "Method: #{action} \nURL: #{url} \nOptions: #{options&.to_json} \nOnly tracking: #{only_tracking} \nResponse from: CALI"
            puts "Data: #{data.to_json}" if data
          end

          return JSON.parse(response&.body)
        end
      rescue
        return response
      end
    end

    def method_missing(name, *args, &block)
      name.to_s.include?('__') ? separator = '__' : separator = '_'
      # split the name to identify their elements
      name_splitted = name.to_s.split(separator)
      # count the elements
      name_len = name_splitted.size
      # the action always be the first element
      action = name_splitted.first
      raise 'NoActionError' unless %w[get create post update put delete destroy verify_response_status].include?(action)
      # the object always be the last element
      object = separator == '__' ? name_splitted.last.gsub('_', '-') : name_splitted.last
      # get intermediate url elements
      route_array = []
      (name_len - 1).times do |n|
        next if n === 0 or n === name_len - 1

        n = name_splitted[n]
        self.replacements.each do |object|
          n = n.gsub(object[:old_value], object[:new_value])
        end
        route_array.push n
      end
      route = route_array.join('/')

      slug = nil
      response = nil
      uri = Addressable::URI.new

      if action == 'get'
        if args.first.class == Hash
          uri.query_values = args.first
        elsif args.first.class == String or Integer
          slug = args.first
          uri.query_values = args[1]
        end

        url = self.get_url(route, object, uri, slug)
        response = self.send("#{@scope}_#{action}", url, nil, compatibility_options)
      elsif action == 'post' or action == 'create'
        if args[1].class == Hash
          uri.query_values = args[1]
        end

        url = self.get_url(route, object, uri, slug)
        action = 'post'
        data = args[0]
        response = self.send("#{@scope}_#{action}", url, { data: data }, compatibility_options)
      elsif action == 'put' or action == 'update'
        if args.first.class == String or Integer
          slug = args.first
          uri.query_values = args[2]
        end

        url = self.get_url(route, object, uri, slug)
        action = 'put'
        data = args[1]
        response = self.send("#{@scope}_#{action}", "#{url}", { data: data }, compatibility_options)
      end

      verify_response_status(response, config['sdk']['ignore_http_errors'])

      response ? JSON.parse(response.body) : nil
    end

    def get_url(route, object, uri, slug = nil)
      if slug
        "#{@host}#{@base_url}/#{route}/#{object}/#{slug}#{uri}"
      else
        "#{@host}#{@base_url}/#{route}/#{object}#{uri}"
      end
    end

    def replacements
      [
        { old_value: '_', new_value: '-' },
        { old_value: 'people', new_value: 'crm' },
        { old_value: 'store', new_value: 'ecommerce' }
      ]
    end

    def set_scope(scope)
      @scope = scope
      if scope === 'public' or scope === 'contact'
        @base_url = '/api/v1'
      elsif scope === 'user'
        @base_url = '/api/user/v1'
      else
        @scope = 'public'
        @base_url = '/api/v1'
      end
    end

    ##### HTTP CLIENTS ######
    # Simple HTTP GET
    def http_get(url, headers = nil)
      HTTParty.get(url, headers: headers)
    end

    # Simple HTTP POST
    def http_post(url, headers = nil, data = nil)
      HTTParty.post(url, headers: headers, body: data)
    end

    # Simple HTTP PUT
    def http_put(url, headers = nil, data = nil)
      HTTParty.put(url, headers: headers, body: data)
    end

    # Simple HTTP DELETE
    def http_delete(url, headers = nil, data = nil)
      HTTParty.delete(url, headers: headers, body: data)
    end

    # Start contact context
    def contact_get(url, headers = nil, compatibility_options)
      h = set_headers(compatibility_options, headers)

      self.http_get(url, h)
    end

    def contact_post(url, data, compatibility_options)
      headers = set_headers(compatibility_options)

      self.http_post(url, headers, data)
    end

    def contact_put(url, data, compatibility_options)
      headers = set_headers(compatibility_options)

      self.http_put(url, headers, data)
    end

    # Start User context
    def user_get(url, headers = nil, compatibility_options)
      h = set_headers(compatibility_options, headers)

      self.http_get(url, h)
    end

    def user_post(url, data, compatibility_options)
      self.http_post(url, set_headers(compatibility_options), data)
    end

    def user_put(url, data, compatibility_options)
      self.http_put(url, set_headers(compatibility_options), data)
    end

    def user_delete(url, data, compatibility_options)
      self.http_delete(url, set_headers(compatibility_options), data)
    end

    # End User Context

    def public_get(url, headers = nil, compatibility_options)
      self.http_get(url, set_headers(compatibility_options, headers))
    end

    def public_post(url, headers = nil, data, compatibility_options)
      self.http_post(url, set_headers(compatibility_options, headers), data)
    end

    def public_put(url, headers = nil, data, compatibility_options)
      self.http_put(url, set_headers(compatibility_options, headers), data)
    end

    def set_headers(compatibility_options, headers = nil)
      h = {
        'Accept' => 'application/json',
        'ApiKey' => @api_key
      }
      h['Content-Type'] = 'application/json' unless compatibility_options['no_content_type']
      h['ContactToken'] = @contact_token_id if @contact_token_id
      h['Visit-Id'] = @visit_id if @visit_id
      h['Authorization'] = "Bearer #{@session_token}" if @session_token

      if headers
        headers.each do |k, v|
          h[k] = v
        end
      end

      h
    end

    def verify_response_status(response, ignore_http_errors)
      # Verify if the response is cached
      unless response.kind_of? String
        # Raise an error if response code is not 2xx
        http_status = response&.response&.code&.to_i || 500
        is_success = (http_status >= 200 and http_status < 300)

        if !is_success and !ignore_http_errors
          title = "Request failed with status #{http_status}"
          detail = response&.response&.message || 'Unknown error'

          puts "Error detected: #{http_status}" if @debug
          error_class = Errors::DynamicError.new(self, title, detail, http_status, response&.parsed_response)

          raise error_class if @debug

          raise error_class.error
        end
      end
    end

  end
end
