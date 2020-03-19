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
      return @client.raw("post", "/register-visit-timer", data)
    end

    def register_visit_timer
      return @client.raw("get", "/register-visit-timer")
    end

    def get_content_page
      return @client.raw("get", "/content-pages/#{slug}")
    end

    def get_content_template
      return @client.raw("get", "/content/content-templates/#{slug}")
    end

    def content_instance 
      return @client.raw("get", "/content/content-instances/#{slug}")
    end

    def get_stories
      return @client.raw("get", "/content/stories")
    end

    def get_story(slug)
      return @client.raw("get", "/content/stories/#{slug}")
    end

    def get_form
      return @client.raw("get", "/content/forms/{slug}")
    end

    def submit_form
      return @client.raw("post", "/forms/store", data)
    end
  end
end
