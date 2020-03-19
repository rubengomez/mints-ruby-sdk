require_relative './client.rb'
module Mints
  class User
    attr_reader :client
    def initialize(host, api_key, session_token = nil)
      @client = Mints::Client.new(host, api_key, 'user', session_token)
    end

    def login(email, password)
      data = {
        email: email,
        password: password,
      }
      response = @client.raw("post", "/users/login", data, '/api/v1')
      if response.key? "api_token"
        @client.session_token = response["api_token"]
      end
      return response
    end
    ######################################### CRM #########################################
    ### Contacts ###
    def get_contacts
      return @client.get__crm__contacts
    end

    def get_contact(id)
      return @client.get__crm__contacts(id)
    end

    def create_contact(data)
      return @client.create__crm__contacts(data)
    end

    def update_contact(id, data)
      return @client.update__crm__contacts(id, data)
    end
    ### Companies ###
    def get_companies
      return @client.get__crm__companies
    end

    def get_company(id)
      return @client.get__crm__companies(id)
    end

    def create_company(data)
      return @client.create__crm__companies(data)
    end

    def update_company(id, data)
      return @client.update__crm__companies(id, data)
    end

    ### Deals ###
    def get_deals
      return @client.get__crm__deals
    end

    def get_deal(id)
      return @client.get__crm__deals(id)
    end

    def create_deal(data)
      return @client.create__crm__deals(data)
    end

    def update_deal(id, data)
      return @client.update__crm__deals(id, data)
    end

    ######################################### Content #########################################
    ### Stories ###
    def get_stories
      return @client.get__content__stories
    end

    def get_story(id)
      return @client.get__content__stories(id)
    end

    def create_story(data)
      return @client.create__content__stories(data)
    end

    def update_story(id, data)
      return @client.update__content__stories(id, data)
    end

    ### Content instances ###
    def get_content_instances
      return @client.get__content__instances
    end

    def get_content_instance(id)
      return @client.get__content__instances(id)
    end

    def create_content_instance(data)
      return @client.create__content__instances(data)
    end

    def update_content_instance(id, data)
      return @client.update__content__instances(id, data)
    end

    ### Content pages ###
    def get_content_pages
      return @client.get__content__pages
    end

    def get_content_page(id)
      return @client.get__content__pages(id)
    end

    def create_content_page(data)
      return @client.create__content__pages(data)
    end

    def update_content_page(id, data)
      return @client.update__content__pages(id, data)
    end

    ### Content templates ###
    def get_content_templates
      return @client.get__content__templates
    end

    def get_content_page(id)
      return @client.get__content__templates(id)
    end

    def create_content_page(data)
      return @client.create__content__templates(data)
    end

    def update_content_page(id, data)
      return @client.update__content__templates(id, data)
    end

    ######################################### Ecommerce #########################################
    ### Products ###
    def get_products
      return @client.get__ecommerce__products
    end

    def get_product(id)
      return @client.get__ecommerce__products(id)
    end

    def create_product(data)
      return @client.create__ecommerce__products(data)
    end

    def update_product(id, data)
      return @client.update__ecommerce__products(id, data)
    end

    ### Locations ###
    def get_locations
      return @client.get__ecommerce__locations
    end

    def get_location(id)
      return @client.get__ecommerce__locations(id)
    end

    def create_location(data)
      return @client.create__ecommerce__locations(data)
    end

    def update_location(id, data)
      return @client.update__ecommerce__locations(id, data)
    end
  end
end
