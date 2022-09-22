require "httparty"
require "json"
require "addressable"
require "redis"
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
        if compatibility_options === nil
          compatibility_options = {}
        end
        base_url = @base_url if !base_url
        uri = ""
        if (options && options.class == Hash)
          if (options[:jfilters] && options[:jfilters].class == Hash)
            options[:jfilters] = Base64.encode64(JSON.generate(options[:jfilters]))
          end
          uri = Addressable::URI.new
          uri.query_values = options
        end

        full_url = "#{@host}#{base_url}#{url}#{uri}"
        response = nil
        if action === 'get'

          template = ERB.new File.new("#{Rails.root}/mints_config.yml.erb").read
          config = YAML.load template.result(binding)
          url_need_cache = false
          result_from_cache = false
          time = 0

          if config['redis_cache']['use_cache']
            config['redis_cache']['groups'].each do |group|
              group['urls'].each do |url|
                  if full_url.match url
                    time = group['time']
                    url_need_cache = true
                    @redis_server = Redis.new(host: config['redis_cache']['redis_host'], port: config['redis_cache']['redis_port'] ? config['redis_cache']['redis_port'] : 6379, db: config['redis_cache']['redis_db'] ? config['redis_cache']['redis_db'] : 1)
                    redis_response = @redis_server.get(full_url)
                    if redis_response
                      response = redis_response
                      result_from_cache = true

                      headers = nil
                      if only_tracking
                        headers = {"Only-Tracking" => "true"}
                        #when is already in redis notify to California to register the object usage
                        #cali_response = self.send("#{@scope}_#{action}", "#{full_url}", headers, compatibility_options)
                      end
                    else
                      response = self.send("#{@scope}_#{action}", "#{full_url}", nil, compatibility_options)
                      @redis_server.setex(full_url,time,response)
                    end
                    break
                  end
              end
              break if url_need_cache
            end
          end

          if !url_need_cache
            response = self.send("#{@scope}_#{action}", "#{full_url}", nil, compatibility_options)
          end

        elsif action === 'create' or action === 'post'
          action = 'post'
          response = self.send("#{@scope}_#{action}", "#{full_url}", data, compatibility_options)
        elsif action === 'put' or action === 'patch' or action ==='update'
          action = 'put'
          response = self.send("#{@scope}_#{action}", "#{full_url}", data, compatibility_options)
        elsif action === 'delete' or action === 'destroy'
          action = 'delete'
          response = self.send("#{@scope}_#{action}", "#{full_url}", data, compatibility_options)
        end

        begin
          if result_from_cache
            if @debug
              puts "Method: #{action} \nURL: #{url} \nOptions: #{options.to_json} \nOnly tracking: #{only_tracking} \nResponse from: REDIS"
              if (data)
                puts "Data: #{data.to_json}"
              end
            end
            return JSON.parse(response)
          else
            if (response.response.code == "404")
              raise 'NotFoundError'
            end
            if @debug
              puts "Method: #{action} \nURL: #{url} \nOptions: #{options.to_json} \nOnly tracking: #{only_tracking} \nResponse from: CALI"
              if (data)
                puts "Data: #{data.to_json}"
              end
            end
            return JSON.parse(response.body)
          end
        rescue
          return response
        end
      end

      def method_missing(name, *args, &block)
        name.to_s.include?("__") ? separator = "__" : separator = "_"
        # split the name to identify their elements
        name_spplited = name.to_s.split(separator)
        # count the elments
        name_len = name_spplited.size
        # the action always be the first element
        action = name_spplited.first
        raise 'NoActionError' unless ['get', 'create', 'post', 'update', 'put', 'delete', 'destroy'].include?(action)
        # the object always be the last element
        object = separator == "__" ? name_spplited.last.gsub("_","-") : name_spplited.last
        # get intermediate url elements
        route_array = []
        (name_len-1).times do |n|
            if n == 0 or n == name_len-1
              next
            end
            n = name_spplited[n]
            self.replacements().each do |object|
              n = n.gsub(object[:old_value], object[:new_value])
            end
            route_array.push n
        end
        route = route_array.join("/")


        slug = nil
        uri = Addressable::URI.new
        if action == "get"
          if args.first.class == Hash
            uri.query_values = args.first
          elsif args.first.class == String or Integer
            slug = args.first
            uri.query_values = args[1]
          end
          url = self.get_url(route, object, uri, slug)
          response = self.send("#{@scope}_#{action}", url, nil, compatibility_options)
        elsif action == "post" or action == "create"
          if args[1].class == Hash
            uri.query_values = args[1]
          end
          url = self.get_url(route, object, uri, slug)
          action = 'post'
          data = args[0]
          response = self.send("#{@scope}_#{action}", url, {data: data}, compatibility_options)
        elsif action == "put" or action == "update"
           if args.first.class == String or Integer
            slug = args.first
            uri.query_values = args[2]
          end
          url = self.get_url(route, object, uri, slug)
          action = 'put'
          id = args[0]
          data = args[1]
          response = self.send("#{@scope}_#{action}", "#{url}", {data: data}, compatibility_options)
        end

        if response.response.code == "404"
          raise 'NotFoundError'
        elsif response.response.code == "500"
          raise 'InternalServerError'
        end
        return JSON.parse(response.body)
      end

      def get_url(route, object, uri, slug = nil)
        if (slug)
          return "#{@host}#{@base_url}/#{route}/#{object}/#{slug}#{uri}"
        else
          return "#{@host}#{@base_url}/#{route}/#{object}#{uri}"
        end
      end

      def replacements
        return [
            {old_value: '_', new_value: '-'},
            {old_value: 'people', new_value: 'crm'},
            {old_value: 'store', new_value: 'ecommerce'}
        ]
      end

      def set_scope(scope)
        @scope = scope
        if scope == "public"
            @base_url = "/api/v1"
        elsif scope == "contact"
            @base_url = "/api/v1"
        elsif scope == "user"
            @base_url = "/api/user/v1"
        else
            @scope = "public"
            @base_url = "/api/v1"
        end
      end

      ##### HTTTP CLIENTS ######
      # Simple HTTP GET
      def http_get(url, headers = nil)
        # if @debug
        #   puts "Url:"
        #   puts url
        #   puts "Headers:"
        #   puts headers
        #   puts "Method: get"
        # end
        return headers ? HTTParty.get(url, :headers => headers) : HTTParty.get(url)
      end

      # Simple HTTP POST
      def http_post(url, headers = nil, data = nil)
        # if @debug
        #   puts "Url:"
        #   puts url
        #   puts "Headers:"
        #   puts headers
        #   puts "Data:"
        #   puts data
        #   puts "Method: post"
        # end
        return headers ? HTTParty.post(url, :headers=> headers, :body => data) : HTTParty.post(url, :body => data)
      end

      # Simple HTTP PUT
      def http_put(url, headers = nil, data = nil)
        # if @debug
        #   puts "Url:"
        #   puts url
        #   puts "Headers:"
        #   puts headers
        #   puts "Data:"
        #   puts data
        #   puts "Method: put"
        # end
        return headers ? HTTParty.put(url, :headers=> headers, :body => data) : HTTParty.put(url, :body => data)
      end

      # Simple HTTP DELETE
      def http_delete(url, headers = nil, data = nil)
        # if @debug
        #   puts "Url:"
        #   puts url
        #   puts "Headers:"
        #   puts headers
        #   puts "Data:"
        #   puts data
        #   puts "Method: delete"
        # end
        return headers ? HTTParty.delete(url, :headers=> headers, :body => data) : HTTParty.delete(url, :body => data)
      end

      # Start contact context
      def contact_get(url, headers = nil, compatibility_options)
        h = {
          "ApiKey" => @api_key,
          "Accept" => "application/json",
          "ContactToken" => @contact_token_id
        }
        h["Content-Type"] = "application/json" unless compatibility_options['no_content_type']
        h["Authorization"] = "Bearer #{@session_token}" if @session_token
        if headers
          headers.each do |k,v|
            h[k] = v
          end
        end
        return self.http_get(url, h)
      end

      def contact_post(url, data, compatibility_options)
        headers = {
          "ApiKey" => @api_key,
          "Accept" => "application/json",
          "ContactToken" => @contact_token_id
        }
        headers["Content-Type"] = "application/json" unless compatibility_options['no_content_type']
        headers["Authorization"] = "Bearer #{@session_token}" if @session_token
        return self.http_post(url, headers, data)
      end

      def contact_put(url, data, compatibility_options)
        headers = {
          "ApiKey" => @api_key,
          "Accept" => "application/json",
          "ContactToken" => @contact_token_id
        }
        headers["Content-Type"] = "application/json" unless compatibility_options['no_content_type']
        headers["Authorization"] = "Bearer #{@session_token}" if @session_token
        return self.http_put(url, headers, data)
      end

      # Start User context
      def user_get(url, headers = nil, compatibility_options)
        h = {
          "Accept" => "application/json",
          "ApiKey" => @api_key
        }
        h["Content-Type"] = "application/json" unless compatibility_options['no_content_type']
        h["Authorization"] = "Bearer #{@session_token}" if @session_token
        if headers
          headers.each do |k,v|
            h[k] = v
          end
        end
        return self.http_get(url, h)
      end

      def user_post(url, data, compatibility_options)
        headers = {
          "Accept" => "application/json",
          "ApiKey" => @api_key
        }
        headers["Content-Type"] = "application/json" unless compatibility_options['no_content_type']
        headers["Authorization"] = "Bearer #{@session_token}" if @session_token
        return self.http_post(url, headers, data)
      end

      def user_put(url, data, compatibility_options)
        headers = {
          "Accept" => "application/json",
          "ApiKey" => @api_key
        }
        headers["Content-Type"] = "application/json" unless compatibility_options['no_content_type']
        headers["Authorization"] = "Bearer #{@session_token}" if @session_token
        return self.http_put(url, headers, data)
      end

      def user_delete(url, data, compatibility_options)
        headers = {
          "Accept" => "application/json",
          "ApiKey" => @api_key
        }
        headers["Content-Type"] = "application/json" unless compatibility_options['no_content_type']
        headers["Authorization"] = "Bearer #{@session_token}" if @session_token
        return self.http_delete(url, headers, data)
      end
      # End User Context

      def public_get(url, headers = nil, compatibility_options)
        h = {
          "Accept" => "application/json",
          "ApiKey" => @api_key
        }
        h["Content-Type"] = "application/json" unless compatibility_options['no_content_type']
        h["ContactToken"] = @contact_token_id if @contact_token_id
        h["Visit-Id"] = @visit_id if @visit_id
        if headers
          headers.each do |k,v|
            h[k] = v
          end
        end
        self.http_get(url, h)
      end

      def public_post(url, headers = nil, data, compatibility_options)
        h = {
          "Accept" => "application/json",
          "ApiKey" => @api_key
        }
        h["Content-Type"] = "application/json" unless compatibility_options['no_content_type']
        h["ContactToken"] = @session_token if @session_token
        if headers
          headers.each do |k,v|
            h[k] = v
          end
        end
        self.http_post(url, h, data)
      end

      def public_put(url, headers = nil, data, compatibility_options)
        h = {
          "Accept" => "application/json",
          "ApiKey" => @api_key
        }
        h["Content-Type"] = "application/json" unless compatibility_options['no_content_type']
        h["ContactToken"] = @contact_token_id if @contact_token_id
        if headers
          headers.each do |k,v|
            h[k] = v
          end
        end
        self.http_put(url, h, data)
      end
  end
end
