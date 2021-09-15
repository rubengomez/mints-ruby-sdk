require_relative './client.rb'
module Mints
  ##
  # == User context API
  # User class contains functions that needs an API key and a session token as authentication
  # == Usage example
  # Initialize
  #     client = Mints::User.new(mints_url, api_key)
  # Call any function
  #     client.get_contacts
  # == Single resource options
  # * +include+ - [String] include a relationship
  # * +attributes+ - [Boolean] attach attributes to response
  # * +categories+ - [Boolean] attach categories to response
  # * +tags+ - [Boolean] attach tags to response
  # == Resource collections options 
  # * +search+ - [String] filter by a search word
  # * +scopes+ - [String] filter by a scope
  # * +filters+ - [String] filter by where clauses
  # * +jfilters+ - [String] filter using complex condition objects
  # * +catfilters+ - [String] filter by categories
  # * +fields+ - [String] indicates the columns that will be selected
  # * +sort+ - [String] indicates the columns that will be selected
  # * +include+ - [String] include a relationship
  # * +attributes+ - [Boolean] attach attributes to response
  # * +categories+ - [Boolean] attach categories to response
  # * +taxonomies+ - [Boolean] attach categories to response
  # * +tags+ - [Boolean] attach tags to response
  class User
    attr_reader :client
    def initialize(host, api_key, session_token = nil, debug = false)
      @client = Mints::Client.new(host, api_key, 'user', session_token, nil, debug)
      @content_route = '/api/user/v1/content'
    end

    def login(email, password)
      data = {
        email: email,
        password: password,
      }
      response = @client.raw("post", "/users/login", nil, data, '/api/v1')
      if response.key? "api_token"
        @client.session_token = response["api_token"]
      end
      return response
    end

    def magic_link_login(token)
      response = @client.raw("get", "/users/magic-link-login/#{token}", nil, nil, '/api/v1')
      return response
    end

    ##
    # === Send magic link to user
    def send_magic_link(email, redirectUrl = '', lifeTime = 24)
      data = {
        email: email,
        redirectUrl: redirectUrl,
        lifeTime: lifeTime
      }
      response = @client.raw("post", "/users/magic-link", nil, { data: data }, '/api/v1')
      return response
    end

    ######################################### CRM #########################################
    
    ##
    # == Contacts
    #

    ##
    # === Get contacts support data.
    #
    # ==== Example
    #     @data = @mints_user.get_contacts_support_data
    def get_contacts_support_data
      return @client.raw("get", "/crm/contacts/support-data")
    end
    
    ##
    # === Get online activity.
    # Get online activity of a contact.
    #
    # ==== Parameters
    # id:: (Integer) -- Contact id.
    #
    # ==== Example
    #     @data = @mints_user.get_online_activity(5)
    def get_online_activity(id)
      return @client.raw("get", "/crm/contacts/#{id}/online-activity")
    end

    ##
    # === Get contacts.
    # Get a collection of contacts.
    #
    # ==== Parameters
    # options:: (Hash) -- List of {Resource collection Options}[#class-Mints::User-label-Resource+collections+options+] shown above can be used as parameter.
    # use_post:: (Boolean) -- Variable to determine if the request is by 'post' or 'get' functions.
    #
    # ==== First Example
    #     @data = @mints_user.get_contacts
    #
    # ==== Second Example
    #     options = { 
    #       "sort": "id",
    #       "fields[contacts]": "id, email"
    #     }
    #     @data = @mints_user.get_contacts(options)
    #
    # ==== Third Example
    #     options = { 
    #       "sort": "id",
    #       "fields[contacts]": "id, email"
    #     }
    #     @data = @mints_user.get_contacts(options, true)
    def get_contacts(options = nil, use_post = true)
      return get_query_results("/crm/contacts", options, use_post)
    end

    ##
    # === Get contact.
    # Get a contact data.
    #
    # ==== Parameters
    # id:: (Integer) -- Contact id.
    # options:: (Hash) -- List of {Resource collection Options}[#class-Mints::User-label-Resource+collections+options+] shown above can be used as parameter.
    #
    # ==== First Example
    #     @data = @mints_user.get_contact(5)
    #
    # ==== Second Example
    #     options = { 
    #       "sort": "id",
    #       "fields[contacts]": "id, email"
    #     }
    #     @data = @mints_user.get_contact(5, options)
    def get_contact(id, options = nil)
      return @client.raw("get", "/crm/contacts/#{id}", options)
    end

    ##
    # === Create contact.
    # Create a contact with data.
    #
    # ==== Parameters
    # data:: (Hash) -- Data to be submited.
    #
    # ==== Example
    #     data = {
    #       "email": "email@example.com",
    #       "given_name": "Given_Name",
    #       "last_name": "Last_Name",
    #       "password": "123456"
    #     }
    #     @data = @mints_user.create_contact(data)
    def create_contact(data)
      return @client.raw("post", "/crm/contacts", nil, data_transform(data))
    end

    ##
    # === Update contact.
    # Update contact data.
    #
    # ==== Parameters
    # id:: (Integer) -- Contact id.
    # data:: (Hash) -- Data to be submited.
    #
    # ==== Example
    #     data = {
    #       "email": "email_modified@example.com",
    #       "company_id": 3
    #     }
    #     @data = @mints_user.update_contact(65, data)
    def update_contact(id, data)
      return @client.raw("put", "/crm/contacts/#{id}", nil, data_transform(data))
    end

    ##
    # === Get contact deals.
    # Get a collection of deals of a contact.
    #
    # ==== Parameters
    # contact_id:: (Integer) -- Contact id.
    #
    # ==== Example
    #     @data = @mints_user.get_contact_deal(5)
    def get_contact_deal(contact_id)
      return @client.raw("get", "/crm/contacts/#{contact_id}/deals")
    end

    ##
    # === Create contact deal.
    # Create a contact deal with data.
    #
    # ==== Parameters
    # contact_id:: (Integer) -- Contact id.
    # data:: (Hash) -- Data to be submited.
    #
    # ==== Example
    #     data = {
    #       "deal_id": 6
    #     }
    #     @data = @mints_user.create_contact_deal(5, data)
    def create_contact_deal(contact_id, data)
      return @client.raw("post", "/crm/contacts/#{contact_id}/deals", nil, data)
    end

    ##
    # === Delete contact deal.
    # Delete a contact deal with data.
    #
    # ==== Parameters
    # contact_id:: (Integer) -- Contact id.
    # deal_id:: (Integer) -- Deal id.
    #
    # ==== Example
    #     @data = @mints_user.delete_contact_deal(5, 100)
    def delete_contact_deal(contact_id, deal_id)
      return @client.raw("delete", "/crm/contacts/#{contact_id}/deals/#{deal_id}")
    end

    ##
    # === Get contact user.
    # Get user data of a contact.
    #
    # ==== Parameters
    # contact_id:: (Integer) -- Contact id.
    # options:: (Hash) -- List of {Resource collection Options}[#class-Mints::User-label-Resource+collections+options+] shown above can be used as parameter.
    #
    # ==== Example
    #     @data = @mints_user.get_contact_user(66)
    def get_contact_user(contact_id)
      return @client.raw("get", "/crm/contacts/#{contact_id}/users")
    end

    ##
    # === Create contact user.
    # Relate a contact with an user.
    #
    # ==== Parameters
    # contact_id:: (Integer) -- Contact id.
    # data:: (Hash) -- Data to be submited.
    #
    # ==== Example
    #     data = { 
    #       "user_id": 9
    #     }
    #     @data = @mints_user.create_contact_user(66, data)
    def create_contact_user(contact_id, data)
      return @client.raw("post", "/crm/contacts/#{contact_id}/users", nil, data)
    end

    ##
    # === Delete contact user.
    # Delete a relationship between a contact and an user.
    #
    # ==== Parameters
    # contact_id:: (Integer) -- Contact id.
    # id:: (Integer) -- User id.
    #
    # ==== Example
    #     @data = @mints_user.delete_contact_user(153, 9)
    def delete_contact_user(contact_id, id)
      return @client.raw("delete", "/crm/contacts/#{contact_id}/users/#{id}")
    end

    ##
    # === Get contact segments.
    # Get segments of a contact.
    #
    # ==== Parameters
    # contact_id:: (Integer) -- Contact id.
    #
    # ==== Example
    #     @data = @mints_user.get_contact_segments(1)
    def get_contact_segments(contact_id)
      return @client.raw("get", "/crm/contacts/#{contact_id}/segments")
    end

    ##
    # === Get contact submissions.
    # Get submissions of a contact.
    #
    # ==== Parameters
    # contact_id:: (Integer) -- Contact id.
    #
    # ==== Example
    #     @data = @mints_user.get_contact_submissions(146)
    def get_contact_submissions(contact_id)
      return @client.raw("get", "/crm/contacts/#{contact_id}/submissions")
    end

    ##
    # === Get contact tags.
    # Get tags of a contact.
    #
    # ==== Parameters
    # contact_id:: (Integer) -- Contact id.
    #
    # ==== Example
    #     @data = @mints_user.get_contact_tags(1)
    def get_contact_tags(contact_id)
      return @client.raw("get", "/crm/contacts/#{contact_id}/tags")
    end

    ##
    # === Get contact magic links.
    # Get magic links of a contact.
    #
    # ==== Parameters
    # contact_id:: (Integer) -- Contact id.
    #
    # ==== Example
    #     @data = @mints_user.get_contact_magic_links(150)
    def get_contact_magic_links(contact_id)
      return @client.raw("get", "/crm/contacts/#{contact_id}/magic-links")
    end

    ##
    # === Create contact merge.
    # Merge contacts.
    #
    # ==== Parameters
    # id:: (Integer) -- Contact id.
    # data:: (Hash) -- Data to be submited. It contains ids to be merged.
    #
    # ==== Example
    #     data = {
    #       "mergeContactIds": [152]
    #     }
    #     @data = @mints_user.merge_contacts(151, data)
    def merge_contacts(id, data)
      return @client.raw("post", "/crm/contacts/#{id}/merge", nil, data_transform(data))
    end

    ##
    # === Send magic links.
    # Send magic links to contacts.
    #
    # ==== Parameters
    # data:: (Hash) -- Data to be submited.
    #
    # ==== Example
    #     data = { 
    #       "contacts": ["email_1@example.com", "email_2@example.com", "email_3@example.com"],
    #       "templateId": 2,
    #       "redirectUrl": "",
    #       "lifeTime": 1440,
    #       "maxVisits": 3
    #     }
    #     @data = @mints_user.send_magic_links(data)
    def send_magic_links(data)
      return @client.raw("post", "/crm/contacts/send-magic-link", nil, data_transform(data))
    end

    ##
    # == Contacts Bulk Actions
    #

    ##
    # === Delete contacts.
    # Delete different contacts.
    #
    # ==== Parameters
    # data:: (Hash) -- Data to be submited.
    #
    # ==== Example
    #     data = { 
    #       "ids": [ 67, 68, 69 ]
    #     }
    #     @data = @mints_user.delete_contacts(data)
    def delete_contacts(data) #TODO: ContactController.delete need a success output
      return @client.raw("delete", "/crm/contacts/delete", nil, data_transform(data))
    end

    ##
    # == Deals
    #

    ##
    # === Get deal permits.
    # Get permits of a deal.
    #
    # ==== Parameters
    # id:: (Integer) -- Deal id.
    #
    # ==== Example
    #     @data = @mints_user.get_deal_permits(7)
    def get_deal_permits(id)
      return @client.raw("get", "/crm/deals/#{id}/permits")
    end

    ##
    # === Get deal support data.
    # Get support data of deals.
    #
    # ==== Example
    #     @data = @mints_user.get_deal_support_data
    def get_deal_support_data
      return @client.raw("get", "/crm/deals/support-data")
    end

    ##
    # === Get deal currencies.
    # Get currencies of deals.
    #
    # ==== Example
    #     @data = @mints_user.get_deal_currencies
    def get_deal_currencies
      return @client.raw("get", "/crm/deal/currencies")
    end

    # === Get deals.
    # Get a collection of deals.
    #
    # ==== Parameters
    # options:: (Hash) -- List of {Resource collection Options}[#class-Mints::User-label-Resource+collections+options+] shown above can be used as parameter.
    # use_post:: (Boolean) -- Variable to determine if the request is by 'post' or 'get' functions.
    #
    # ==== First Example
    #     @data = @mints_user.get_deals
    #
    # ==== Second Example
    #     options = { "fields": "id, title" }
    #     @data = @mints_user.get_deals(options)
    #
    # ==== Third Example
    #     options = { "fields": "id, title" }
    #     @data = @mints_user.get_deals(options, false)
    def get_deals(options = nil, use_post = true)
      return get_query_results("/crm/deals", options, use_post)
    end

    # === Get deal.
    # Get a deal info.
    #
    # ==== Parameters
    # id:: (Integer) -- Deal id.
    # options:: (Hash) -- List of {Resource collection Options}[#class-Mints::User-label-Resource+collections+options+] shown above can be used as parameter.
    #
    # ==== First Example
    #     @data = @mints_user.get_deal(1)
    #
    # ==== Second Example
    #     options = { "fields": "id, title" }
    #     @data = @mints_user.get_deal(1, options)
    def get_deal(id, options = nil)
      return @client.raw("get", "/crm/deals/#{id}", options)
    end

    # === Create deal.
    # Create a deal with data.
    #
    # ==== Parameters
    # data:: (Hash) -- Data to be submited.
    #
    # ==== Example
    #     data = {
    #       "dealData": {
    #         "title": "New deal",
    #         "stepId": 1,
    #         "value": 10500
    #       }
    #     }
    #     @data = @mints_user.create_deal(data)
    def create_deal(data)
      return @client.raw("post", "/crm/deals", nil, data)
    end

    # === Update deal.
    # Update a deal data.
    #
    # ==== Parameters
    # id:: (Integer) -- Deal id.
    # data:: (Hash) -- Data to be submited.
    #
    # ==== Example
    #     data = {
    #       "title": "New Deal Modified"
    #     }
    #     @data = @mints_user.update_deal(102, data)
    def update_deal(id, data)
      return @client.raw("put", "/crm/deals/#{id}", nil, correct_json(data))
    end

    ##
    # == Companies
    #

    ##
    # === Get companies support data.
    # Get support data of companies.
    #
    # ==== Example
    #     @data = @mints_user.get_companies_support_data
    def get_companies_support_data
      return @client.raw("get", "/crm/companies/support-data")
    end

    # === Get companies.
    # Get a collection of companies.
    #
    # ==== Parameters
    # options:: (Hash) -- List of {Resource collection Options}[#class-Mints::User-label-Resource+collections+options+] shown above can be used as parameter.
    # use_post:: (Boolean) -- Variable to determine if the request is by 'post' or 'get' functions.
    #
    # ==== First Example
    #     @data = @mints_user.get_companies
    #
    # ==== Second Example
    #     options = { "fields": "id, title", "sort": "-id" }
    #     @data = @mints_user.get_companies(options)
    #
    # ==== Third Example
    #     options = { "fields": "id, title", "sort": "-id" }
    #     @data = @mints_user.get_companies(options, false)
    def get_companies(options = nil, use_post = true)
      return get_query_results("/crm/companies", options, use_post)
    end

    # === Get company.
    # Get a company info.
    #
    # ==== Parameters
    # id:: (Integer) -- Company id.
    # options:: (Hash) -- List of {Resource collection Options}[#class-Mints::User-label-Resource+collections+options+] shown above can be used as parameter.
    #
    # ==== First Example
    #     @data = @mints_user.get_company(21)
    #
    # ==== Second Example
    #     options = { "fields": "id, title" }
    #     @data = @mints_user.get_company(21, options)
    def get_company(id, options = nil)
      return @client.raw("get", "/crm/companies/#{id}", options)
    end

    # === Create company.
    # Create a company with data.
    #
    # ==== Parameters
    # data:: (Hash) -- Data to be submited.
    #
    # ==== Example
    #     data = {
  #         "title": "Company Title",
  #         "alias": "Alias",
  #         "website": "www.company.example.com",
  #         "street1": "Company St",
  #         "city": "Company City",
  #         "region": "Company Region",
  #         "postal_code": "12345",
  #         "country_id": 144,
  #         "tax_identifier": nil
    #     }
    #     @data = @mints_user.create_company(data)
    def create_company(data)
      return @client.raw("post", "/crm/companies/", nil, data_transform(data))
    end

    # === Update company.
    # Update a company info.
    #
    # ==== Parameters
    # id:: (Integer) -- Company id.
    # data:: (Hash) -- Data to be submited.
    #
    # ==== Example
    #     data = { 
    #       "title": "Company Title Modified"
    #     }
    #     @data = @mints_user.update_company(23, data)
    def update_company(id, data)
      return @client.raw("put", "/crm/companies/#{id}", nil, data_transform(data))
    end

    ##
    # == Companies Bulk Actions
    #

    # === Delete Companies.
    # Delete a group of companies.
    #
    # ==== Parameters
    # data:: (Hash) -- Data to be submited.
    #
    # ==== Example
    #     data = {
    #       "ids": [ 21, 22 ]
    #     }
    #     @data = @mints_user.delete_companies(data)
    def delete_companies(data)
      return @client.raw("delete", "/crm/companies/delete", nil, data_transform(data))
    end

    ##
    # == Workflows
    #

    # === Get workflows.
    # Get a collection of workflows.
    #
    # ==== Parameters
    # options:: (Hash) -- List of {Resource collection Options}[#class-Mints::User-label-Resource+collections+options+] shown above can be used as parameter.
    #
    # ==== First Example
    #     @data = @mints_user.get_workflows
    #
    # ==== Second Example
    #     options = { "sort": "title", "fields": "title" }
    #     @data = @mints_user.get_workflows(options)
    def get_workflows(options = nil)
      return @client.raw("get", "/crm/workflows", options)
    end

    # === Get workflow.
    # Get a workflow.
    #
    # ==== Parameters
    # id:: (Integer) -- Workflow id.
    # options:: (Hash) -- List of {Resource collection Options}[#class-Mints::User-label-Resource+collections+options+] shown above can be used as parameter.
    #
    # ==== First Example
    #     @data = @mints_user.get_workflow(1)
    #
    # ==== Second Example
    #     options = { "fields": "id, title" }
    #     @data = @mints_user.get_workflow(1, options)
    def get_workflow(id, options = nil)
      return @client.raw("get", "/crm/workflows/#{id}", options)
    end

    # === Create workflow.
    # Create a workflow with data.
    #
    # ==== Parameters
    # data:: (Hash) -- Data to be submited.
    #
    # ==== Example
    #     data = {
    #       "title": "New Workflow",
    #       "object_type": "deals"
    #     }
    #     @data = @mints_user.create_workflow(data)
    def create_workflow(data)
      return @client.raw("post", "/crm/workflows/", nil, data)
    end

    # === Update workflow.
    # Update a workflow info.
    #
    # ==== Parameters
    # id:: (Integer) -- Workflow id.
    # data:: (Hash) -- Data to be submited.
    #
    # ==== Example
    #     data = {
    #       "title": "New Workflow Modified"
    #     }
    #     @data = @mints_user.update_workflow(7, data)
    def update_workflow(id, data)
      return @client.raw("put", "/crm/workflows/#{id}", nil, correct_json(data))
    end

    ##
    # == Workflow Step Objects
    #

    # === Get workflow step objects.
    # Get a collection of workflow step objects.
    #
    # ==== Parameters
    # options:: (Hash) -- List of {Resource collection Options}[#class-Mints::User-label-Resource+collections+options+] shown above can be used as parameter.
    #
    # ==== First Example
    #     @data = @mints_user.get_step_objects
    #
    # ==== Second Example
    #     options = { "fields": "id" }
    #     @data = @mints_user.get_step_objects(options)
    def get_step_objects(options = nil)
      return @client.raw("get", "/crm/step-objects", options)
    end

    # === Get workflow step object.
    # Get a workflow step object info.
    #
    # ==== Parameters
    # id:: (Integer) -- Workflow step object id.
    # options:: (Hash) -- List of {Resource collection Options}[#class-Mints::User-label-Resource+collections+options+] shown above can be used as parameter.
    #
    # ==== First Example
    #     @data = @mints_user.get_step_object(1)
    #
    # ==== Second Example
    #     options = { "fields": "id, step_id" }
    #     @data = @mints_user.get_step_object(1, options)
    def get_step_object(id, options = nil)
      return @client.raw("get", "/crm/step-objects/#{id}", options)
    end

    # === Create workflow step object.
    # Create a workflow step object with data.
    #
    # ==== Parameters
    # data:: (Hash) -- Data to be submited.
    #
    # ==== Example
    #     data = {
    #       "objectType": "deals",
    #       "stepId": 9,
    #       "objectId": 1
    #     }
    #     @data = @mints_user.create_step_object(data)
    def create_step_object(data)
      return @client.raw("post", "/crm/step-objects/", nil, data_transform(data))
    end

    # === Update workflow step object.
    # Update a workflow step object info.
    #
    # ==== Parameters
    # id:: (Integer) -- Workflow step object id.
    # data:: (Hash) -- Data to be submited.
    #
    # ==== Example
    #     data = {
    #       "stepId": 10
    #     }
    #     @data = @mints_user.update_step_object(128, data)
    def update_step_object(id, data)
      return @client.raw("put", "/crm/step-objects/#{id}", nil, correct_json(data))
    end

    # === Get workflow step object by object type.
    # Get a workflow step object info by an object type.
    #
    # ==== Parameters
    # objectType:: (String) -- Object type.
    # objectId:: (Integer) -- Workflow step object id.
    # options:: (Hash) -- List of {Resource collection Options}[#class-Mints::User-label-Resource+collections+options+] shown above can be used as parameter.
    #
    # ==== First Example
    #     @data = @mints_user.get_step_object_by_object_type("deals", 1)
    #
    # ==== Second Example
    #     options = { "fields": "id, object_id" }
    #     @data = @mints_user.get_step_object_by_object_type("deals", 1, options)
    def get_step_object_by_object_type(objectType, objectId, options = nil)
      return @client.raw("get", "/crm/step-objects/#{objectType}/#{objectId}", options)
    end

    ##
    # == Workflow Steps
    #

    # === Create workflow step.
    # Create a workflow step with data.
    #
    # ==== Parameters
    # data:: (Hash) -- Data to be submited.
    #
    # ==== Example
    #     data = { 
    #       "stepTitle": "Step Title",
    #       "workflowId": 1
    #     }
    #     @data = @mints_user.create_workflow_step(data)
    def create_workflow_step(data)
      return @client.raw("post", "/crm/steps", nil, data)
    end

    # === Update workflow step.
    # Update a workflow step info.
    #
    # ==== Parameters
    # id:: (Integer) -- Workflow step id.
    # data:: (Hash) -- Data to be submited.
    #
    # ==== Example
    #     data = { "stepTitle": "Step Title Modified" }
    #     @data = @mints_user.update_workflow_step(23, data)
    def update_workflow_step(id, data)
      return @client.raw("put", "/crm/steps/#{id}", nil, correct_json(data))
    end

    # === Delete workflow step.
    # Delete a workflow step.
    #
    # ==== Parameters
    # id:: (Integer) -- Workflow step id.
    #
    # ==== Example
    #     @data = @mints_user.delete_workflow_step(51)
    def delete_workflow_step(id)
      return @client.raw("delete", "/crm/steps/#{id}")
    end

    ##
    # == Favorites #TODO: NOT CHECKED, NO DATA IN DB
    #

    def update_multiple_favorites(data)
      return @client.raw("put", "/crm/favorites", nil, data)
    end

    def get_favorites(options = nil)
      return @client.raw("get", "/crm/favorites", options)
    end

    def update_favorites(id, data)
      return @client.raw("put", "/crm/favorites/#{id}", nil, data)
    end

    ##
    # == Segments
    #

    # === Get segments support data.
    # Get segments support data.
    #
    # ==== Example
    #     @data = @mints_user.get_segments_support_data
    def get_segments_support_data
      return @client.raw("get", "/crm/segments/support-data")
    end

    # === Get segments attributes.
    # Get segments attributes.
    #
    # ==== Parameters
    # options:: (Hash) -- List of {Resource collection Options}[#class-Mints::User-label-Resource+collections+options+] shown above can be used as parameter.
    #
    # ==== Example
    #     options = { "object_type": "contacts" }
    #     @data = @mints_user.get_segments_attributes(options)
    def get_segments_attributes(options = nil)
      return @client.raw("get", "/crm/segments/attributes", options)
    end

    # === Get segment group.
    # Get segment group.
    #
    # ==== Parameters
    # groupId:: (String) -- Group's name.
    #
    # ==== Example
    #     @data = @mints_user.get_segment_group("users")
    def get_segment_group(groupId)
      return @client.raw("get", "/crm/segments/groups/#{groupId}")
    end

    # === Duplicate segment.
    # Duplicate a segment.
    #
    # ==== Parameters
    # id:: (Integer) -- Segment id.
    # data:: (Hash) -- Data to be submited.
    #
    # ==== Example
    #     data = { 
    #       "options": [] 
    #     }
    #     @data = @mints_user.duplicate_segment(107, data)
    def duplicate_segment(id, data)
      return @client.raw("post", "/crm/segments/#{id}/duplicate", nil, data)
    end
    
    # === Get segments.
    # Get a collection of segments.
    #
    # ==== Parameters
    # options:: (Hash) -- List of {Resource collection Options}[#class-Mints::User-label-Resource+collections+options+] shown above can be used as parameter.
    #
    # ==== First Example
    #     @data = @mints_user.get_segments
    #
    # ==== Second Example
    #     options = { "fields": "id", "sort": "-id" }
    #     @data = @mints_user.get_segments(options)
    def get_segments(options = nil)
      return @client.raw("get", "/crm/segments", options)
    end

    # === Get segment.
    # Get a segment info.
    #
    # ==== Parameters
    # id:: (Integer) -- Segment id.
    # options:: (Hash) -- List of {Resource collection Options}[#class-Mints::User-label-Resource+collections+options+] shown above can be used as parameter.
    #
    # ==== First Example
    #     @data = @mints_user.get_segment(1)
    #
    # ==== Second Example
    #     options = { "fields": "id, title" }
    #     @data = @mints_user.get_segment(1, options)
    def get_segment(id, options = nil)
      return @client.raw("get", "/crm/segments/#{id}", options)
    end

    # === Create segment.
    # Create a segment with data.
    #
    # ==== Parameters
    # data:: (Hash) -- Data to be submited.
    #
    # ==== Example
    #     data = { 
    #       "title": "New Segment",
    #       "object_type": "deals"
    #     }
    #     @data = @mints_user.create_segment(data)
    def create_segment(data)
      return @client.raw("post", "/crm/segments", nil, data_transform(data))
    end

    # === Update segment.
    # Update a segment info.
    #
    # ==== Parameters
    # id:: (Integer) -- Segment id.
    # data:: (Hash) -- Data to be submited.
    #
    # ==== Example
    #     data = { 
    #       "title": "New Segment Modified"
    #     }
    #     @data = @mints_user.update_segment(118, data)
    def update_segment(id, data)
      return @client.raw("put", "/crm/segments/#{id}", nil, data_transform(data))
    end

    # === Delete segment.
    # Delete a segment.
    #
    # ==== Parameters
    # id:: (Integer) -- Segment id.
    #
    # ==== Example
    #     @mints_user.delete_segment(113)
    def delete_segment(id)
      return @client.raw("delete", "/crm/segments/#{id}")
    end

    ##
    # == Users
    #

    ###
    # === Get users.
    # Get users info.
    #
    # ==== Parameters
    # options:: (Hash) -- List of {Resource collection Options}[#class-Mints::User-label-Resource+collections+options+] shown above can be used as parameter.
    #
    # ==== First Example
    #     @data = @mints_user.get_users
    #
    # ==== Second Example
    #     options = { "sort": "id", "fields": "id, email" }
    #     @data = @mints_user.get_users(options)
    def get_users(options = nil)
      return @client.raw("get", "/crm/users", options)
    end


    ######################################### Content #########################################
    
    
    ##
    # == Pages
    #

    ###
    # === Get page groups.
    # Get page groups.
    #
    # ==== Example
    #     @data = @mints_user.get_page_groups
    def get_page_groups
      return @client.raw("get", "/content/pages/groups")
    end

    # === Get pages.
    # Get a collection of pages.
    #
    # ==== Example
    #     @data = @mints_user.get_pages
    def get_pages
      return @client.raw("get", "/content/pages")
    end

    # === Get page.
    # Get a page.
    #
    # ==== Parameters
    # id:: (Integer) -- Page id.
    #
    # ==== Example
    #     @data = @mints_user.get_page(1)
    def get_page(id)
      return @client.raw("get", "/content/pages/#{id}")
    end

    # === Create page.
    # Create a page with data.
    #
    # ==== Parameters
    # data:: (Hash) -- Data to be submited.
    #
    # ==== Example
    #     data = { 
    #       "title": "New Page",
    #       "slug": "new-page-slug",
    #       "description": "New page description"
    #     }
    #     @data = @mints_user.create_page(data)
    def create_page(data)
      return @client.raw("post", "/content/pages", nil, data_transform(data))
    end

    # === Update page.
    # Update a page info.
    #
    # ==== Parameters
    # id:: (Integer) -- Page id.
    # data:: (Hash) -- Data to be submited.
    #
    # ==== Example
    #     data = { 
    #       "title": "New Page Modified"
    #     }
    #     @data = @mints_user.update_page(5, data)
    def update_page(id, data)
      return @client.raw("put", "/content/pages/#{id}", nil, correct_json(data))
    end

    # === Delete page.
    # Delete a page.
    #
    # ==== Parameters
    # id:: (Integer) -- Page id.
    #
    # ==== Example
    #     @mints_user.@mints_user.delete_page(3)
    def delete_page(id)
      return @client.raw("delete", "/content/pages/#{id}")
    end

    ##
    # == Forms
    #

    # === Get forms.
    # Get a collection of forms.
    #
    # ==== Parameters
    # options:: (Hash) -- List of {Resource collection Options}[#class-Mints::User-label-Resource+collections+options+] shown above can be used as parameter.
    #
    # ==== First Example
    #     @data = @mints_user.get_forms
    #
    # ==== Second Example
    #     options = { "sort": "id", "fields": "title" }
    #     @data = @mints_user.get_forms(options)
    def get_forms(options = nil)
      return @client.raw("get", "/content/forms", options)
    end

    # === Get form.
    # Get a form info.
    #
    # ==== Parameters
    # id:: (Integer) -- Form id.
    # options:: (Hash) -- List of {Resource collection Options}[#class-Mints::User-label-Resource+collections+options+] shown above can be used as parameter.
    #
    # ==== First Example
    #     @data = @mints_user.get_form(9)
    #
    # ==== Second Example
    #     options = { "sort": "id", "fields": "title" }
    #     @data = @mints_user.get_form(2, options)
    def get_form(id, options = nil)
      return @client.raw("get", "/content/forms/#{id}", options)
    end

    # === Publish form.
    # Publish a form.
    #
    # ==== Parameters
    # id:: (Integer) -- Form id.
    # data:: (Hash) -- Data to be submited.
    #
    # ==== Example
    #     data = {
    #       "data": {
    #         "slug": "new-publish"
    #       }
    #     }
    #     @data = @mints_user.publish_form(1, data.to_json)
    def publish_form(id, data) #FIXME: Doesnt work, pending to review
      return @client.raw("put", "/content/forms/#{id}/publish", nil, data)
    end

    # === Schedule form.
    # Schedule a form in a specified date.
    #
    # ==== Parameters
    # id:: (Integer) -- Form id.
    # data:: (Hash) -- Data to be submited.
    #
    # ==== Example
    #     data = {
    #       "data": {
    #         "scheduled_at": "2021-09-06T20:29:16+00:00"
    #       }
    #     }
    #     @data = @mints_user.schedule_form(1, data.to_json)
    def schedule_form(id, data) #FIXME: Doesnt work, pending to review
      return @client.raw("put", "/content/forms/#{id}/schedule", nil, data)
    end

    # === Revert published form.
    # Revert a published form.
    #
    # ==== Parameters
    # id:: (Integer) -- Form id.
    #
    # ==== Example
    #     @data = @mints_user.revert_published_form(1)
    def revert_published_form(id) #TODO: Not tested
      return @client.raw("get", "/content/forms/#{id}/revert-published-data")
    end

    ##
    # == Conversations
    #

    ###
    # === Get conversations.
    # Get a collection of conversations.
    #
    # ==== Parameters
    # options:: (Hash) -- List of {Resource collection Options}[#class-Mints::User-label-Resource+collections+options+] shown above can be used as parameter.
    #
    # ==== First Example
    #     @data = @mints_user.get_conversations
    #
    # ==== Second Example
    #     options = { "fields": "title" }
    #     @data = @mints_user.get_conversations(options)
    def get_conversations(options = nil)
      return @client.raw("get", "/content/conversations", options)
    end

    # === Get conversation.
    # Get a conversation info.
    #
    # ==== Parameters
    # id:: (Integer) -- Conversation id.
    # options:: (Hash) -- List of {Resource collection Options}[#class-Mints::User-label-Resource+collections+options+] shown above can be used as parameter.
    #
    # ==== First Example
    #     @data = @mints_user.get_conversation(1)
    #
    # ==== Second Example
    #     options = { "fields": "title" }
    #     @data = @mints_user.get_conversation(1, options)
    def get_conversation(id, options = nil)
      return @client.raw("get", "/content/conversations/#{id}", options)
    end

    # === Create conversation.
    # Create a conversation with data.
    #
    # ==== Parameters
    # data:: (Hash) -- Data to be submited.
    #
    # ==== Example
    #     data = {
    #       "title": "New Conversation"
    #     }
    #     @data = @mints_user.create_conversation(data)
    def create_conversation(data)
      return @client.raw("post", "/content/conversations", nil, data_transform(data))
    end

    # === Update conversation.
    # Update a conversation info.
    #
    # ==== Parameters
    # id:: (Integer) -- Conversation id.
    # data:: (Hash) -- Data to be submited.
    #
    # ==== Example
    #     data = {
    #       "title": "New Conversation Modified"
    #     }
    #     @data = @mints_user.update_conversation(13, data)
    def update_conversation(id, data)
      return @client.raw("put", "/content/conversations/#{id}", nil, data_transform(data))
    end

    # === Delete conversation.
    # Delete a conversation.
    #
    # ==== Parameters
    # id:: (Integer) -- Conversation id.
    #
    # ==== Example
    #     @data = @mints_user.delete_conversation(11)
    def delete_conversation(id)
      return @client.raw("delete", "/content/conversations/#{id}")
    end
    
    # === Update conversation status.
    # Update a conversation status.
    #
    # ==== Parameters
    # id:: (Integer) -- Conversation id.
    # data:: (Hash) -- Data to be submited.
    #
    # ==== Example
    #     data = {
    #       "status": "read"
    #     }
    #     @data = @mints_user.update_conversation_status(13, data)
    def update_conversation_status(id, data)
      return @client.raw("put", "/content/conversations/#{id}/status", nil, data_transform(data))
    end

    # === Get conversation participants.
    # Get participants in a conversation.
    #
    # ==== Parameters
    # id:: (Integer) -- Conversation id.
    #
    # ==== Example
    #     @data = @mints_user.get_conversation_participants(1)
    def get_conversation_participants(id)
      return @client.raw("get", "/content/conversations/#{id}/participants")
    end

    # === Attach user in conversation.
    # Attach an user in a conversation.
    #
    # ==== Parameters
    # id:: (Integer) -- Conversation id.
    # data:: (Hash) -- Data to be submited.
    #
    # ==== Example
    #     data = {
    #       "user_id": 2
    #     }
    #     @data = @mints_user.attach_user_in_conversation(13, data)
    def attach_user_in_conversation(id, data)
      return @client.raw("post", "/content/conversations/#{id}/attach-user", nil, data_transform(data))
    end

    # === Detach user in conversation.
    # Detach an user in a conversation.
    #
    # ==== Parameters
    # id:: (Integer) -- Conversation id.
    # data:: (Hash) -- Data to be submited.
    #
    # ==== Example
    #     data = {
    #       "user_id": 2
    #     }
    #     @data = @mints_user.detach_user_in_conversation(13, data)
    def detach_user_in_conversation(id, data)
      return @client.raw("post", "/content/conversations/#{id}/detach-user", nil, data_transform(data))
    end

    # === Attach contact in conversation.
    # Attach a contact in a conversation.
    #
    # ==== Parameters
    # id:: (Integer) -- Conversation id.
    # data:: (Hash) -- Data to be submited.
    #
    # ==== Example
    #     data = {
    #       "contact_id": 2
    #     }
    #     @data = @mints_user.attach_contact_in_conversation(1, data)
    def attach_contact_in_conversation(id, data)
      return @client.raw("post", "/content/conversations/#{id}/attach-contact", nil, data_transform(data))
    end

    # === Detach contact in conversation.
    # Detach a contact in a conversation.
    #
    # ==== Parameters
    # id:: (Integer) -- Contact id.
    # data:: (Hash) -- Data to be submited.
    #
    # ==== Example
    #     data = {
    #       "contact_id": 2
    #     }
    #     @data = @mints_user.detach_contact_in_conversation(1, data)
    def detach_contact_in_conversation(id, data)
      return @client.raw("post", "/content/conversations/#{id}/detach-contact", nil, data_transform(data))
    end

    ##
    # == Messages
    #
    
    ###
    # === Get messages.
    # Get a collection of messages.
    #
    # ==== Parameters
    # options:: (Hash) -- List of {Resource collection Options}[#class-Mints::User-label-Resource+collections+options+] shown above can be used as parameter.
    #
    # ==== First Example
    #     @data = @mints_user.get_messages
    #
    # ==== Second Example
    #     options = { "fields": "value" }
    #     @data = @mints_user.get_messages(options)
    def get_messages(options = nil)
      return @client.raw("get", "/content/messages", options)
    end

    # === Get message.
    # Get a message info.
    #
    # ==== Parameters
    # id:: (Integer) -- Message id.
    # options:: (Hash) -- List of {Resource collection Options}[#class-Mints::User-label-Resource+collections+options+] shown above can be used as parameter.
    #
    # ==== First Example
    #     @data = @mints_user.get_message(1)
    #
    # ==== Second Example
    #     options = { "fields": "value" }
    #     @data = @mints_user.get_message(1, options)
    def get_message(id, options = nil)
      return @client.raw("get", "/content/messages/#{id}", options)
    end

    # === Create message.
    # Create a message with data.
    #
    # ==== Parameters
    # data:: (Hash) -- Data to be submited.
    #
    # ==== Example
    #     data = {
    #       "type": "text",
    #       "conversation_id": 1,
    #       "sender_type": "User",
    #       "sender_id": 1,
    #       "value": {
    #         "text": "Hello"
    #       }
    #     }
    #     @data = @mints_user.create_message(data)
    def create_message(data)
      return @client.raw("post", "/content/messages", nil, data_transform(data))
    end
    
    # === Update message.
    # Update a message info.
    #
    # ==== Parameters
    # id:: (Integer) -- Message id.
    # data:: (Hash) -- Data to be submited.
    #
    # ==== Example
    #     data = {
    #       "value": {
    #         "text": "Hello World!"
    #       }
    #     }
    #     @data = @mints_user.update_message(102, data)
    def update_message(id, data)
      return @client.raw("put", "/content/messages/#{id}", nil, data_transform(data))
    end
    
    # === Delete message.
    # Delete a message.
    #
    # ==== Parameters
    # id:: (Integer) -- Message id.
    #
    # ==== Example
    #     @data = @mints_user.delete_message(101)
    def delete_message(id)
      return @client.raw("delete", "/content/messages/#{id}")
    end

    ##
    # == Forms
    #

    # === Duplicate form.
    # Duplicate a form.
    #
    # ==== Parameters
    # id:: (Integer) -- Form id.
    #
    # ==== Example
    #     @data = @mints_user.duplicate_form(3)
    def duplicate_form(id)
      return @client.raw("post", "/content/forms/#{id}/duplicate")
    end

    # === Get form support data.
    # Get form support data.
    #
    # ==== Example
    #     @data = @mints_user.get_form_support_data
    def get_form_support_data
      return @client.raw("get", "/content/forms/support-data")
    end

    # === Get form submissions.
    # Get form submissions.
    #
    # ==== Parameters
    # options:: (Hash) -- List of {Resource collection Options}[#class-Mints::User-label-Resource+collections+options+] shown above can be used as parameter.
    #
    # ==== First Example
    #     @data = @mints_user.get_form_submissions
    #
    # ==== Second Example
    #     options = { "fields": "id" }
    #     @data = @mints_user.get_form_submissions(options)
    def get_form_submissions(options = nil)
      return @client.raw("get", "/content/forms/submissions", options)
    end

    # === Create form.
    # Create a form with data.
    #
    # ==== Parameters
    # data:: (Hash) -- Data to be submited.
    #
    # ==== Example
    #     data = {
    #       "title": "New Form",
    #       "slug": "new-form-slug"
    #     }
    #     @data = @mints_user.create_form(data)
    def create_form(data)
      return @client.raw("post", "/content/forms", nil, data_transform(data))
    end

    # === Update form.
    # Update a form info.
    #
    # ==== Parameters
    # id:: (Integer) -- Form id.
    # data:: (Hash) -- Data to be submited.
    #
    # ==== Example
    #     data = {
    #       "title": "New Form Modified",
    #       "slug": "new-form-slug"
    #     }
    #     @data = @mints_user.update_form(3, data)
    def update_form(id, data)
      return @client.raw("put", "/content/forms/#{id}", nil, data_transform(data))
    end

    # === Delete form.
    # Delete a form.
    #
    # ==== Parameters
    # id:: (Integer) -- Form id.
    #
    # ==== Example
    #     @data = @mints_user.delete_form(9)
    def delete_form(id)
      return @client.raw("delete", "/content/forms/#{id}")
    end

    ##
    # == Content templates
    #

    # === Get content template instances.
    # Get instances of a content template.
    #
    # ==== Parameters
    # templateId:: (Integer) -- Template id.
    #
    # ==== Example
    #     @data = @mints_user.get_content_template_instances(1)
    def get_content_template_instances(templateId)
      return @client.raw("get", "/content/templates/#{templateId}/instances")
    end

    # === Duplicate content template.
    # Duplicate a content template.
    #
    # ==== Parameters
    # id:: (Integer) -- Content template id.
    #
    # ==== Example
    #     @data = @mints_user.get_content_template(1)
    def duplicate_content_template(id)
      return @client.raw("post", "/content/templates/#{id}/duplicate/")
    end

    # === Get content templates.
    # Get a collection of content templates.
    #
    # ==== Parameters
    # options:: (Hash) -- List of {Resource collection Options}[#class-Mints::User-label-Resource+collections+options+] shown above can be used as parameter.
    #
    # ==== First Example
    #     @data = @mints_user.get_content_templates
    #
    # ==== Second Example
    #     options = { "sort": "title" }
    #     @data = @mints_user.get_content_templates(options)
    def get_content_templates(options = nil)
      return @client.raw("get", "/content/templates", options)
    end

    # === Get content template.
    # Get a content template.
    #
    # ==== Parameters
    # id:: (Integer) -- Content template id.
    #
    # ==== Example
    #     @data = @mints_user.get_content_template(1)
    def get_content_template(id)
      return @client.raw("get", "/content/templates/#{id}")
    end

    # === Create content template.
    # Create a content template with data.
    #
    # ==== Parameters
    # data:: (Hash) -- Data to be submited.
    #
    # ==== Example
    #     data = {
    #       "template": {
    #         "title": "New Content Template",
    #         "slug": "new-content-template-slug",
    #         "description": "New Content Template Description"
    #       }
    #     }
    #     @data = @mints_user.create_content_template(data)
    def create_content_template(data)
      #TODO: Inform ContentTemplateController.store method has been modified
      return @client.raw("post", "/content/templates", nil, data)
    end

    # === Update content template.
    # Update a content template info.
    #
    # ==== Parameters
    # id:: (Integer) -- Content template id.
    # data:: (Hash) -- Data to be submited.
    #
    # ==== Example
    #     data = {
    #       "template": {
    #         "title": "New Content Template Modified",
    #         "slug": "new-content-template-slug",
    #         "description": "New Content Template Description"
    #       }
    #     }
    #     @data = @mints_user.update_content_template(7, data)
    def update_content_template(id, data)
       #TODO: Inform ContentTemplateController.update method has been modified
      return @client.raw("put", "/content/templates/#{id}", nil, correct_json(data))
    end

    # === Delete content template.
    # Delete a content template.
    #
    # ==== Parameters
    # id:: (Integer) -- Content template id.
    #
    # ==== Example
    #     @data = @mints_user.delete_content_template(1)
    def delete_content_template(id)
      #TODO: Inform ContentTemplateController.destroy method has been modified
      return @client.raw("delete", "/content/templates/#{id}")
    end

    ##
    # == Content Instances
    #

    # === Get content instances.
    # Get a collection of content instances.
    #
    # ==== Parameters
    # options:: (Hash) -- List of {Resource collection Options}[#class-Mints::User-label-Resource+collections+options+] shown above can be used as parameter.
    #
    # ==== First Example
    #     @data = @mints_user.get_content_instances
    #
    # ==== Second Example
    #     options = { "fields": "id" }
    #     @data = @mints_user.get_content_instances(options)
    def get_content_instances(options = nil)
      return @client.raw("get", "/content/instances", options)
    end

    # === Duplicate content instance.
    # Duplicate a content instance.
    #
    # ==== Parameters
    # id:: (Integer) -- Content instance id.
    # data:: (Hash) -- Data to be submited.
    #
    # ==== Example
    #     data = { 
    #       "options": [] 
    #     }
    #     @data = @mints_user.duplicate_content_instance(1, data)
    def duplicate_content_instance(id, data)
      return @client.raw("post", "/content/instances/#{id}/duplicate", nil, data)
    end
    
    # === Get content instance.
    # Get a content instance info.
    #
    # ==== Parameters
    # id:: (Integer) -- Content instance id.
    # options:: (Hash) -- List of {Resource collection Options}[#class-Mints::User-label-Resource+collections+options+] shown above can be used as parameter.
    #
    # ==== First Example
    #     @data = @mints_user.get_content_instance(1)
    #
    # ==== Second Example
    #     options = { "fields": "id, title" }
    #     @data = @mints_user.get_content_instance(1, options)
    def get_content_instance(id, options = nil)
      return @client.raw("get", "/content/instances/#{id}", options)
    end

    # === Publish content instance.
    # Publish a content instance.
    #
    # ==== Parameters
    # id:: (Integer) -- Content instance id.
    # data:: (Hash) -- Data to be submited.
    #
    # ==== Example
    #     data = {
    #       "title": "New publish",
    #       "slug": "new-publish",
    #       "content_template_id": 1
    #     }
    #     @data = @mints_user.publish_content_instance(2, data)
    def publish_content_instance(id, data)
      return @client.raw("put", "/content/instances/#{id}/publish", nil, data_transform(data))
    end

    # === Schedule content instance.
    # Schedule a content instance in a specified date.
    #
    # ==== Parameters
    # id:: (Integer) -- Content instance id.
    # data:: (Hash) -- Data to be submited.
    #
    # ==== Example
    #     data = { 
    #       "scheduled_at": "2021-09-06T20:29:16+00:00"
    #     }
    #     @data = @mints_user.schedule_content_instance(1, data)
    def schedule_content_instance(id, data)
      return @client.raw("put", "/content/instances/#{id}/schedule", nil, data_transform(data))
    end

    # === Revert published content instance.
    # Revert a published content instance.
    #
    # ==== Parameters
    # id:: (Integer) -- Content instance id.
    #
    # ==== Example
    #     @data = @mints_user.revert_published_content_instance(1)
    def revert_published_content_instance(id)
      return @client.raw("get", "/content/instances/#{id}/revert-published-data")
    end

    # === Create content instance.
    # Create a content instance with data.
    #
    # ==== Parameters
    # data:: (Hash) -- Data to be submited.
    #
    # ==== Example
    #     data = {
    #       "title": "New Content Instance",
    #       "content_template_id": 1,
    #       "slug": "new-content-instance-slug"
    #     }
    #     @data = @mints_user.create_content_instance(data)
    def create_content_instance(data)
      return @client.raw("post", "/content/instances",  nil, data_transform(data))
    end

    # === Update content instance.
    # Update a content instance info.
    #
    # ==== Parameters
    # id:: (Integer) -- Content instance id.
    # data:: (Hash) -- Data to be submited.
    #
    # ==== Example
    #     data = {
    #       "title": "New Content Instance Modified",
    #       "content_template_id": 1,
    #       "slug": "new-content-instance-slug"
    #     }
    #     @data = @mints_user.update_content_instance(18, data)
    def update_content_instance(id, data)
      return @client.raw("put", "/content/instances/#{id}", nil, data_transform(data))
    end

    # === Delete content instance.
    # Delete a content instance.
    #
    # ==== Parameters
    # id:: (Integer) -- Content instance id.
    #
    # ==== Example
    #     @data = @mints_user.delete_content_instance(20)
    def delete_content_instance(id)
      return @client.raw("delete", "/content/instances/#{id}")
    end

    ##
    # == OTHER
    #

    # === Get authors.
    # Get authors.
    #
    # ==== Example
    #     @data = @mints_user.get_authors
    def get_authors
      return @client.raw("get", "/content/authors")
    end

    # === Get keywords.
    # Get a collection of keywords.
    #
    # ==== Parameters
    # options:: (Hash) -- List of {Resource collection Options}[#class-Mints::User-label-Resource+collections+options+] shown above can be used as parameter.
    #
    # ==== First Example
    #     @data = @mints_user.get_keywords
    #
    # ==== Second Example
    #     options = { "fields": "title" }
    #     @data = @mints_user.get_keywords(options)
    def get_keywords(options = nil)
      return @client.raw("get", "/content/keywords", options)
    end

    # === Get public images url.
    # Get public images url.
    #
    # ==== Example
    #     @data = @mints_user.get_public_images_url
    def get_public_images_url
      return @client.raw("get", "/content/public-images-url")
    end

    # === Get stages.
    # Get a collection of stages.
    #
    # ==== Parameters
    # options:: (Hash) -- List of {Resource collection Options}[#class-Mints::User-label-Resource+collections+options+] shown above can be used as parameter.
    #
    # ==== First Example
    #     @data = @mints_user.get_stages
    #
    # ==== Second Example
    #     options = { "fields": "title" }
    #     @data = @mints_user.get_stages(options)
    def get_stages(options = nil)
      return @client.raw("get", "/content/stages", options)
    end

    ##
    # == dam
    #

    # === Get dam loadtree.
    # Get dam loadtree.
    #
    # ==== Example
    #     @data = @mints_user.get_dam_loadtree
    def get_dam_loadtree
      return @client.raw("get", "/content/dam/loadtree")
    end

    # === Get dam asset locations.
    # Get an asset locations in dam.
    #
    # ==== Parameters
    # options:: (Hash) -- List of {Resource collection Options}[#class-Mints::User-label-Resource+collections+options+] shown above can be used as parameter.
    #
    # ==== Example
    #     @data = @mints_user.get_dam_asset_locations(options)
    def get_dam_asset_locations(options)
      return @client.raw("get", "/content/dam/asset-locations", options)
    end
    
    def paste_dam(data) #FIXME: Controller detect object array like a single array.
      return @client.raw("post", "/content/dam/paste", nil, data)
    end

    # === Rename dam.
    # Rename folder or asset in dam.
    #
    # ==== Parameters
    # data:: (Hash) -- Data to be submited.
    #
    # ==== Example
    #     data = {
    #       "itemType": "asset",
    #       "id": 21,
    #       "title": "accusantium",
    #       "description": "Ea cupiditate",
    #       "slug": "accusantium"
    #     }
    #     @data = @mints_user.rename_dam(data)
    def rename_dam(data)
      return @client.raw("post", "/content/dam/rename", nil, data)
    end

    # === Search dam.
    # Search folder or asset in dam.
    #
    # ==== Parameters
    # data:: (Hash) -- Data to be submited.
    #
    # ==== Example
    #     data = {
    #       "searchFor": "accusantium"
    #     }
    #     @data = @mints_user.search_dam(data)
    def search_dam(data)
      return @client.raw("post", "/content/dam/search", nil, data)
    end

    def send_to_trash_dam(data) #FIXME: Invalid argument supplied for foreach()
      return @client.raw("post", "/content/dam/sendToTrash", nil, data)
    end

    def delete_dam(data) #FIXME: Invalid argument supplied for foreach()
      return @client.raw("post", "/content/dam/delete", nil, data)
    end

    # === Create dam folder.
    # Create a folder in dam.
    #
    # ==== Parameters
    # data:: (Hash) -- Data to be submited.
    #
    # ==== Example
    #     data = {
    #       "folder_name": "new folder",
    #       "slug": "newfolder"
    #     }
    #     @data = @mints_user.create_dam_folder(data)
    def create_dam_folder(data)
      return @client.raw("post", "/content/folders/create", nil, data)
    end

    ##
    # == Assets
    #

    def upload_asset(data)
      return @client.raw("post", "/content/assets/upload", nil, data)
    end

    # === Get asset link info.
    # Get information of an asset by url.
    #
    # ==== Parameters
    # data:: (Hash) -- Data to be submited.
    #
    # ==== Example
    #     data = { "link": "https://www.example.com/img/img.jpg" }
    #     @data = @mints_user.get_asset_link_info(data)
    def get_asset_link_info(data)
      return @client.raw("post", "/content/assets/getLinkInfo", nil, data)
    end

    # === Download asset.
    # Get information of an asset.
    #
    # ==== Parameters
    # * +id+ - [Integer] Asset id.
    #
    # ==== Example
    #     @data = @mints_user.download_asset(2)
    def download_asset(id) #FIXME: File not found at path, error in result but method works
      return @client.raw("get", "/content/assets/download/#{id}")
    end

    def edit_asset_size(data) #TODO: Not tested
      return @client.raw("post", "/content/assets/editSize", nil, data)
    end

    def upload_asset_variation(data) #FIXME: Call to a member function guessClientExtension() on null
      return @client.raw("post", "/content/assets/uploadVariation", nil, data)
    end

    def create_asset_size(data) #FIXME: Trying to get property 'path' of non-object
      return @client.raw("post", "/content/assets/createSize", nil, data)
    end

    def update_asset_variation(id, data) #TODO:
      return @client.raw("post", "/content/assets/updateVariation/#{id}", nil, data)
    end

    def get_asset_sizes(id) #FIXME: wrong number of arguments (given 1, expected 0)
      return @client.raw("get", "/content/assets/sizes/#{id}")
    end

    def get_original_asset(id) #FIXME: Doesn't return JSON
      return @client.raw("get", "/content/assets/original/#{id}")
    end

    def get_asset_variation(id)
      #FIXME: Id 1 and 4: Trying to get property 'path' of non-object
      #FIXME: Id 2 and 3: File not found at path maybe doesnt exist
      return @client.raw("get", "/content/assets/variation/#{id}")
    end

    def get_asset_sizes(options)
      return @client.raw("get", "/content/assets/getSizes", options)
    end

    def get_asset_usage(options)
      return @client.raw("get", "/content/assets/usage", options)
    end

    def delete_asset_variation #TODO: Not tested
      return @client.raw("get", "/content/assets/deleteVariation")
    end

    def delete_asset_size #TODO: Not tested
      return @client.raw("get", "/content/assets/deleteSize")
    end

    def get_asset_info(options)
      return @client.raw("get", "/content/assets/getAssetInfo", options)
    end

    def generate_asset_variation(data) #FIXME: Trying to get property 'width' of non-object
      return @client.raw("post", "/content/assets/generateAssetVariations", nil, data)
    end

    def get_asset_doc_types
      return @client.raw("get", "/content/assets/docTypes")
    end

    def get_asset_public_route
      return @client.raw("get", "/content/assets/publicRoute")
    end

    ##
    # == Story Template
    #

    # === Get support data of story template.
    # Get support data used in a story template.
    #
    # ==== Parameters
    # id:: (Integer) -- Story template id.
    #
    # ==== Example
    #     @data = @mints_user.get_support_data_of_story_template(1)
    def get_support_data_of_story_template(id)
      return @client.raw("get", "/content/story-templates/support-data/stories/#{id}")
    end

    # === Get support data of story templates.
    # Get support data used in story templates.
    #
    # ==== Example
    #     @data = @mints_user.get_support_data_of_story_templates
    def get_support_data_of_story_templates
      return @client.raw("get", "/content/story-templates/support-data")
    end

    # === Get story templates.
    # Get a collection of story templates.
    #
    # ==== Parameters
    # options:: (Hash) -- List of {Resource collection Options}[#class-Mints::User-label-Resource+collections+options+] shown above can be used as parameter.
    #
    # ==== First Example
    #     @data = @mints_user.get_story_templates
    #
    # ==== Second Example
    #     options = {
    #       "fields": "id, title"
    #     }
    #     @data = @mints_user.get_story_templates(options)
    def get_story_templates(options = nil)
      return @client.raw("get", "/content/story-templates", options)
    end

    # === Get story template.
    # Get a story template info.
    #
    # ==== Parameters
    # id:: (Integer) -- Story template id.
    # options:: (Hash) -- List of {Resource collection Options}[#class-Mints::User-label-Resource+collections+options+] shown above can be used as parameter.
    #
    # ==== First Example
    #     @data = @mints_user.get_story_template(2)
    #
    # ==== Second Example
    #     options = {
    #       "fields": "title"
    #     }
    #     @data = @mints_user.get_story_template(1, options)
    def get_story_template(id, options = nil)
      return @client.raw("get", "/content/story-templates/#{id}", options)
    end

    # === Create story template.
    # Create a story template with data.
    #
    # ==== Parameters
    # data:: (Hash) -- Data to be submited.
    #
    # ==== Example
    #     data = {
    #       "title": "New Story Template",
    #       "slug": "new-story-template-slug"
    #     }
    #     @data = @mints_user.create_story_template(data)
    def create_story_template(data)
      return @client.raw("post", "/content/story-templates", nil, data_transform(data))
    end

    # === Update story template.
    # Update a story template info.
    #
    # ==== Parameters
    # id:: (Integer) -- Story template id.
    # data:: (Hash) -- Data to be submited.
    #
    # ==== Example
    #     data = {
    #       "title": "New Story Template Modified"
    #     }
    #     @data = @mints_user.update_story_template(3, data)
    def update_story_template(id, data)
      return @client.raw("put", "/content/story-templates/#{id}", nil, data_transform(data))
    end

    ##
    # == Story
    #

    # === Publish story.
    # Publish a story.
    #
    # ==== Parameters
    # id:: (Integer) -- Story id.
    # data:: (Hash) -- Data to be submited.
    #
    # ==== Example
    #     data = {
    #       "scheduled_at": "2021-09-06T20:29:16+00:00"
    #     }
    #     @data = @mints_user.publish_story(2, data)
    def publish_story(id, data)
      return @client.raw("put", "/content/stories/#{id}/publish", nil, data_transform(data))
    end

    # === Schedule story.
    # Schedule a story in a specified date.
    #
    # ==== Parameters
    # id:: (Integer) -- Story id.
    # data:: (Hash) -- Data to be submited.
    #
    # ==== Example
    #     data = {
    #       "scheduled_at": "2021-09-06T20:29:16+00:00"
    #     }
    #     @data = @mints_user.schedule_story(1, data)
    def schedule_story(id, data)
      return @client.raw("put", "/content/stories/#{id}/schedule", nil, data_transform(data))
    end

    # === Revert published story.
    # Revert a published story.
    #
    # ==== Parameters
    # id:: (Integer) -- Story id.
    #
    # ==== Example
    #     @data = @mints_user.revert_published_story(1)
    def revert_published_story(id)
      return @client.raw("get", "/content/stories/#{id}/revert-published-data")
    end

    # === Get stories support data.
    # Get support data used in stories.
    #
    # ==== Example
    #     @data = @mints_user.get_stories_support_data
    def get_stories_support_data
      return @client.raw("get", "/content/stories/support-data")
    end

    # === Duplicate story.
    # Duplicate a story.
    #
    # ==== Parameters
    # id:: (Integer) -- Story id.
    # data:: (Hash) -- Data to be submited.
    #
    # ==== Example
    #     data = {
    #       "options": [] 
    #     }
    #     @data = @mints_user.duplicate_story(1, data)
    def duplicate_story(id, data)
      return @client.raw("post", "/content/stories/#{id}/duplicate", nil, data)
    end

    # === Get stories.
    # Get a collection of stories.
    #
    # ==== Parameters
    # options:: (Hash) -- List of {Resource collection Options}[#class-Mints::User-label-Resource+collections+options+] shown above can be used as parameter.
    # use_post:: (Boolean) -- Variable to determine if the request is by 'post' or 'get' functions.
    #
    # ==== First Example
    #     @data = @mints_user.get_stories
    #
    # ==== Second Example
    #     options = {
    #       "fields": "id, title"
    #     }
    #     @data = @mints_user.get_stories(options)
    #
    # ==== Third Example
    #     options = {
    #       "fields": "id, title"
    #     }
    #     @data = @mints_user.get_stories(options, true)
    def get_stories(options = nil, use_post = true)
      return get_query_results("/content/stories", options, use_post)
    end

    # === Get story.
    # Get a story info.
    #
    # ==== Parameters
    # id:: (Integer) -- Story id.
    # options:: (Hash) -- List of {Resource collection Options}[#class-Mints::User-label-Resource+collections+options+] shown above can be used as parameter.
    #
    # ==== First Example
    #     @data = @mints_user.get_story(1)
    #
    # ==== Second Example
    #     options = {
    #       "fields": "id, title"
    #     }
    #     @data = @mints_user.get_story(1, options)
    def get_story(id, options = nil)
      return @client.raw("get", "/content/stories/#{id}", options)
    end

    # === Create story.
    # Create a story with data.
    #
    # ==== Parameters
    # data:: (Hash) -- Data to be submited.
    #
    # ==== Example
    #     data = {
    #       "title": "New Story",
    #       "slug": "new-story",
    #       "social_metadata": "social metadata"
    #     }
    #     @data = @mints_user.create_story(data)
    def create_story(data)
      return @client.raw("post", "/content/stories", nil, data_transform(data))
    end

    # === Update story.
    # Update a story info.
    #
    # ==== Parameters
    # id:: (Integer) -- Story id.
    # data:: (Hash) -- Data to be submited.
    #
    # ==== Example
    #     data = {
    #       "title": "New Story Modified",
    #       "slug": "new-story"
    #     }
    #     @data = @mints_user.update_story(5, data)
    def update_story(id, data)
      return @client.raw("put", "/content/stories/#{id}", nil, data_transform(data))
    end

    # === Delete story.
    # Delete a story.
    #
    # ==== Parameters
    # id:: (Integer) -- Story id.
    #
    # ==== Example
    #     @data = @mints_user.delete_story(6)
    def delete_story(id)
      return @client.raw("delete", "/content/stories/#{id}")
    end

    ##
    # == Message Template
    #

    # === Get variables of content page from message template.
    # Get variables used in a specified content page located in message templates. 
    #
    # ==== Parameters
    # id:: (Integer) -- Content page id.
    #
    # ==== Example
    #     @data = @mints_user.get_variables_of_content_page_from_message_templates(2)
    def get_variables_of_content_page_from_message_templates(id)
      return @client.raw("get", "/content/message-templates/content-pages/#{id}/variables")
    end

    # === Get recipient variables.
    # Get recipient variables in message templates. 
    #
    # ==== Example
    #     @data = @mints_user.get_recipient_variables
    def get_recipient_variables
      return @client.raw("get", "/content/message-templates/recipient-variables")
    end
    
    # === Get driver templates.
    # Get driver templates in message templates. 
    #
    # ==== Example
    #     @data = @mints_user.get_driver_templates
    def get_driver_templates
      return @client.raw("get", "/content/email-templates/driver/templates")
    end

    # === Preview message template.
    # Preview an message template based in data.
    #
    # ==== Parameters
    # data:: (Hash) -- Data to be submited.
    #
    # ==== Example
    #     variables = {
    #       "variable_1": 1,
    #       "variable_2": "City"
    #     }
    #     data = {
    #       "body": "Message Template {{ variable_2 }}",
    #       "variables": variables.to_json
    #     }
    #     @data = @mints_user.preview_message_template(data)
    def preview_message_template(data)
      return @client.raw("post", "/content/message-templates/preview", nil, data_transform(data))
    end

    # === Send Message Template.
    # Send an message template to different contacts.
    #
    # ==== Parameters
    # data:: (Hash) -- Data to be submited.
    #
    # ==== Example
    #     data = {
    #       "contacts": [
    #         { "id": 10 }
    #       ],
    #       "emailTemplateId": 1,
    #       "resend": false
    #     }
    #     @data = @mints_user.send_message_template(data)
    def send_message_template(data)
      return @client.raw("post", "/content/message-templates/send", nil, data_transform(data))
    end

    # === Duplicate Message Template.
    # Duplicate an message template.
    #
    # ==== Parameters
    # id:: (Integer) -- Message template id.
    # data:: (Hash) -- Data to be submited.
    #
    def duplicate_message_template(id, data) #FIXME: Error in duplicating
      return @client.raw("post", "/content/message-templates/#{id}/duplicate", nil, data)
    end

    # === Get message templates.
    # Get a collection of message templates.
    #
    # ==== Parameters
    # options:: (Hash) -- List of {Resource collection Options}[#class-Mints::User-label-Resource+collections+options+] shown above can be used as parameter.
    #
    # ==== First Example
    #     @data = @mints_user.get_message_templates
    #
    # ==== Second Example
    #     options = { "fields": "id" }
    #     @data = @mints_user.get_message_templates(options)
    def get_message_templates(options = nil)
      return @client.raw("get", "/content/message-templates", options)
    end

    # === Get message template.
    # Get an message template info.
    #
    # ==== Parameters
    # id:: (Integer) -- Message template id.
    # options:: (Hash) -- List of {Resource collection Options}[#class-Mints::User-label-Resource+collections+options+] shown above can be used as parameter.
    #
    # ==== First Example
    #     @data = @mints_user.get_message_template(1)
    #
    # ==== Second Example
    #     options = { "fields": "id" }
    #     @data = @mints_user.get_message_template(1, options)
    def get_message_template(id, options = nil)
      return @client.raw("get", "/content/message-templates/#{id}", options)
    end

    # === Create message template.
    # Create an message template with data.
    #
    # ==== Parameters
    # data:: (Hash) -- Data to be submited.
    #
    # ==== Example
    #     data = {
    #       "title": "New Message Template",
    #       "slug": "new-email-template"
    #     }
    #     @data = @mints_user.create_message_template(data)
    def create_message_template(data)
      return @client.raw("post", "/content/message-templates", nil, data_transform(data))
    end

    # === Update message template.
    # Update an message template info.
    #
    # ==== Parameters
    # id:: (Integer) -- Message template id.
    # data:: (Hash) -- Data to be submited.
    #
    # ==== Example
    #     data = {
    #       "data": {
    #         "title": "New Message Template Modified"
    #       }
    #     }
    #     @data = @mints_user.update_message_template(4, data)
    def update_message_template(id, data) #FIXME: Method need 'data' with data_transform method, research why
      return @client.raw("put", "/content/message-templates/#{id}", nil, data_transform(data))
    end

    # === Delete message template.
    # Delete an message template.
    #
    # ==== Parameters
    # id:: (Integer) -- Message template id.
    #
    # ==== Example
    #     @data = @mints_user.delete_message_template(2)
    def delete_message_template(id)
      return @client.raw("delete", "/content/message-templates/#{id}")
    end

    ##
    # == Keywords
    #

    # === Get keyword.
    # Get a keyword.
    #
    # ==== Parameters
    # id:: (Integer) -- Keyword id.
    #
    def get_keyword(id)
      return @client.raw("get", "/content/keywords/#{id}")
    end

    # === Create keyword.
    # Create a keyword with data.
    #
    # ==== Parameters
    # data:: (Hash) -- Data to be submited.
    #
    def create_keyword(data)
      return @client.raw("post", "/content/keywords", nil, data)
    end

    # === Update keyword.
    # Update a keyword info.
    #
    # ==== Parameters
    # id:: (Integer) -- Keyword id.
    # data:: (Hash) -- Data to be submited.
    #
    def update_keyword(id, data) #FIXME: Method doesn't work, controller cannot get keyword info from request variable.
      return @client.raw("put", "/content/keywords/#{id}", nil, data)
    end

    ##
    # == Authors
    #

    # === Get author.
    # Get an author.
    #
    # ==== Parameters
    # id:: (Integer) -- Author id.
    #
    def get_author(id)
      return @client.raw("get", "/content/authors/#{id}")
    end

    # === Create author.
    # Create an author with data.
    #
    # ==== Parameters
    # data:: (Hash) -- Data to be submited.
    #
    def create_author(data)
      return @client.raw("post", "/content/authors", nil, data)
    end

    # === Update author.
    # Update an author info.
    #
    # ==== Parameters
    # id:: (Integer) -- Author id.
    # data:: (Hash) -- Data to be submited.
    #
    def update_author(id, data) #FIXME: Method doesn't work, controller cannot get author data from request variable.
      return @client.raw("put", "/content/authors/#{id}", nil, data)
    end

    ##
    # == Stages
    #

    # === Get stage.
    # Get a stage.
    #
    # ==== Parameters
    # id:: (Integer) -- Stage id.
    #
    def get_stage(id)
      return @client.raw("get", "/content/stages/#{id}")
    end

    # === Create stage.
    # Create a stage with data.
    #
    # ==== Parameters
    # data:: (Hash) -- Data to be submited.
    #
    def create_stage(data) #FIXME: Cannot insert data into database successfully.
      return @client.raw("post", "/content/stages", nil, data)
    end

    # === Update stage.
    # Update a stage info.
    #
    # ==== Parameters
    # id:: (Integer) -- Stage id.
    # data:: (Hash) -- Data to be submited.
    #
    def update_stage(id, data) #FIXME: Method doesn't work, controller cannot get stage data from request variable.
      return @client.raw("put", "/content/stages/#{id}", nil, data)
    end


    ######################################### Marketing #########################################


    ##
    # == Automation
    #

    # === Get automations.
    # Get a collection of automations.
    #
    # ==== Parameters
    # options:: (Hash) -- List of {Resource collection Options}[#class-Mints::User-label-Resource+collections+options+] shown above can be used as parameter.
    #
    def get_automations(options = nil)
      return @client.raw("get", "/marketing/automation", options)
    end

    # === Get automation.
    # Get an automation info.
    #
    # ==== Parameters
    # id:: (Integer) -- Automation id.
    # options:: (Hash) -- List of {Resource collection Options}[#class-Mints::User-label-Resource+collections+options+] shown above can be used as parameter.
    #
    def get_automation(id, options = nil)
      return @client.raw("get", "/marketing/automation/#{id}", options)
    end

    # === Create automation.
    # Create an automation with data.
    #
    # ==== Parameters
    # data:: (Hash) -- Data to be submited.
    #
    def create_automation(data)
      return @client.raw("post", "/marketing/automation/", nil, data)
    end

    # === Update automation.
    # Update an automation info.
    #
    # ==== Parameters
    # id:: (Integer) -- Automation id.
    # data:: (Hash) -- Data to be submited.
    #
    def update_automation(id, data) #FIXME: Method doesn't work, controller cannot get automation data from request variable.
      return @client.raw("put", "/marketing/automation/#{id}", nil, data)
    end

    # === Delete automation.
    # Delete an automation.
    #
    # ==== Parameters
    # id:: (Integer) -- Automation id.
    #
    def delete_automation(id)
      return @client.raw("delete", "/marketing/automation/#{id}")
    end

    # === Get automation executions.
    # Get executions of an automation.
    #
    # ==== Parameters
    # id:: (Integer) -- Automation id.
    #
    def get_automation_executions(id)
      return @client.raw("get", "/marketing/automation/#{id}/executions")
    end
    
    # === Reset automation.
    # Reset an automation.
    #
    # ==== Parameters
    # id:: (Integer) -- Automation id.
    #
    def reset_automation(id)
      return @client.raw("post", "/marketing/automation/#{id}/reset")
    end
    
    # === Duplicate automation.
    # Duplicate an automation.
    #
    # ==== Parameters
    # id:: (Integer) -- Automation id.
    # data:: (Hash) -- Data to be submited.
    #
    def duplicate_automation(id, data)
      return @client.raw("post", "/marketing/automation/#{id}/duplicate", nil, data)
    end


    ######################################### Ecommerce #########################################


    ##
    # == Price List
    #

    # === Get price lists.
    # Get a collection of price lists.
    #
    # ==== Parameters
    # options:: (Hash) -- List of {Resource collection Options}[#class-Mints::User-label-Resource+collections+options+] shown above can be used as parameter.
    #
    def get_price_lists(options = nil)
      return @client.raw("get", "/ecommerce/price-list", options)
    end

    # === Get price list.
    # Get a price list info.
    #
    # ==== Parameters
    # id:: (Integer) -- Price list id.
    # options:: (Hash) -- List of {Resource collection Options}[#class-Mints::User-label-Resource+collections+options+] shown above can be used as parameter.
    #
    def get_price_list(id, options = nil)
      return @client.raw("get", "/ecommerce/price-list/#{id}", options)
    end

    # === Create price list.
    # Create a price list with data.
    #
    # ==== Parameters
    # data:: (Hash) -- Data to be submited.
    #
    def create_price_list(data)
      return @client.raw("post", "/ecommerce/price-list", nil, data)
    end

    # === Update price list.
    # Update a price list info.
    #
    # ==== Parameters
    # id:: (Integer) -- Price list id.
    # data:: (Hash) -- Data to be submited.
    #
    def update_price_list(id, data)
      return @client.raw("put", "/ecommerce/price-list/#{id}", nil, data)
    end

    ##
    # == Product
    #

    # === Update product variations config.
    # Update config of product variations of a product.
    #
    # ==== Parameters
    # productId:: (Integer) -- Product id.
    # data:: (Hash) -- Data to be submited.
    #
    def update_product_variations_config(productId, data) #TODO: Research use
      return @client.raw("post", "/ecommerce/products/update-variations-config/#{productId}", nil, data)
    end

    # === Get product support data.
    # Get support data used in products.
    #
    # ==== Example
    #     @data = @mints_user.get_product_support_data
    def get_product_support_data
      return @client.raw("get", "/ecommerce/products/support-data")
    end

    # === Delete product.
    # Delete a product.
    #
    # ==== Parameters
    # id:: (Integer) -- Product id.
    #
    def delete_product(id)
      return @client.raw("delete", "/ecommerce/products/#{id}")
    end
    
    # === Publish product.
    # Publish a product.
    #
    # ==== Parameters
    # id:: (Integer) -- Product id.
    # data:: (Hash) -- Data to be submited.
    #
    def publish_product(id, data) #TODO: Research data in publish
      return @client.raw("put", "/ecommerce/products/#{id}/publish", nil, data)
    end

    # === Schedule product.
    # Schedule a product.
    #
    # ==== Parameters
    # id:: (Integer) -- Product id.
    # data:: (Hash) -- Data to be submited.
    #
    def schedule_product(id, data)
      return @client.raw("put", "/ecommerce/products/#{id}/schedule", nil, data)
    end

    # === Get product variant options config.
    # Get variant options config used in a product.
    #
    # ==== Parameters
    # id:: (Integer) -- Product id.
    #
    def get_product_variant_options_config(id)
      return @client.raw("get", "/ecommerce/products/#{id}/variant-options-config")
    end

    # === Revert published product.
    # Revert a published product.
    #
    # ==== Parameters
    # id:: (Integer) -- Product id.
    #
    # ==== Example
    #     @data = @mints_user.revert_published_product(2)
    def revert_published_product(id)
      return @client.raw("get", "/ecommerce/products/#{id}/revert-published-data")
    end
    
    # === Get products.
    # Get a collection of products.
    #
    # ==== Parameters
    # options:: (Hash) -- List of {Resource collection Options}[#class-Mints::User-label-Resource+collections+options+] shown above can be used as parameter.
    #
    def get_products(options = nil)
      return @client.raw("get", "/ecommerce/products", options)
    end

    # === Get product.
    # Get a product info.
    #
    # ==== Parameters
    # id:: (Integer) -- Product id.
    # options:: (Hash) -- List of {Resource collection Options}[#class-Mints::User-label-Resource+collections+options+] shown above can be used as parameter.
    #
    def get_product(id, options = nil)
      return @client.raw("get", "/ecommerce/products/#{id}", options)
    end

    # === Create product.
    # Create a product with data.
    #
    # ==== Parameters
    # data:: (Hash) -- Data to be submited.
    #
    def create_product(data)
      return @client.raw("post", "/ecommerce/products/", nil, data)
    end

    # === Update product.
    # Update a product info.
    #
    # ==== Parameters
    # id:: (Integer) -- Product id.
    # data:: (Hash) -- Data to be submited.
    #
    def update_product(id, data)
      return @client.raw("put", "/ecommerce/products/#{id}", nil, data)
    end
    
    ##
    # == Locations
    #

    # === Get locations.
    # Get a collection of locations.
    #
    def get_locations
      return @client.raw("get", "/ecommerce/locations")
    end
    
    # === Get location.
    # Get a location info.
    #
    # ==== Parameters
    # id:: (Integer) -- Location id.
    #
    def get_location(id)
      return @client.raw("get", "/ecommerce/locations/#{id}")
    end

    # === Create location.
    # Create a location with data.
    #
    # ==== Parameters
    # data:: (Hash) -- Data to be submited.
    #
    def create_location(data)
      return @client.raw("post", "/ecommerce/locations", nil, data)
    end

    # === Update location.
    # Update a location info.
    #
    # ==== Parameters
    # id:: (Integer) -- Location id.
    # data:: (Hash) -- Data to be submited.
    #
    def update_location(id, data)
      return @client.raw("put", "/ecommerce/locations/#{id}", nil, data)
    end

    # === Delete location.
    # Delete a location.
    #
    # ==== Parameters
    # id:: (Integer) -- Location id.
    #
    def delete_location(id)
      return @client.raw("delete", "/ecommerce/locations/#{id}")
    end

    ##
    # == Locations Templates
    #

    # === Get location template support data.
    # Get support data used in a location template.
    #
    # ==== Parameters
    # id:: (Integer) -- Location template id.
    #
    def get_location_template_support_data(id)
      return @client.raw("get", "/ecommerce/location-templates/#{id}/support-data")
    end
    
    # === Get location templates support data.
    # Get support data used in location templates.
    #
    # ==== Example
    #     @data = @mints_user.get_location_templates_support_data
    def get_location_templates_support_data
      return @client.raw("get", "/ecommerce/location-templates/support-data")
    end

    # === Get location templates.
    # Get a collection of location templates.
    #
    # ==== Parameters
    # options:: (Hash) -- List of {Resource collection Options}[#class-Mints::User-label-Resource+collections+options+] shown above can be used as parameter.
    #
    def get_location_templates(options = nil)
      return @client.raw("get", "/ecommerce/location-templates", options)
    end

    # === Get location template.
    # Get a location template info.
    #
    # ==== Parameters
    # id:: (Integer) -- Location template id.
    # options:: (Hash) -- List of {Resource collection Options}[#class-Mints::User-label-Resource+collections+options+] shown above can be used as parameter.
    #
    def get_location_template(id, options = nil)
      return @client.raw("get", "/ecommerce/location-templates/#{id}", options)
    end
    
    # === Create location template.
    # Create a location template with data.
    #
    # ==== Parameters
    # data:: (Hash) -- Data to be submited.
    #
    def create_location_template(data)
      return @client.raw("post", "/ecommerce/location-templates", nil, data)
    end
    
    # === Update location template.
    # Update a location template info.
    #
    # ==== Parameters
    # id:: (Integer) -- Location template id.
    # data:: (Hash) -- Data to be submited.
    #
    def update_location_template(id, data)
      return @client.raw("put", "/ecommerce/location-templates/#{id}", nil, data)
    end
    
    ##
    # == Product Variation
    #

    # === Generate product variation.
    # Generate a product variation.
    #
    # ==== Parameters
    # productId:: (Integer) -- Product id.
    # data:: (Hash) -- Data to be submited.
    #
    def generate_product_variation(productId, data) #FIXME: Error
      return @client.raw("post", "/ecommerce/product-variations/generate/#{productId}", nil, data)
    end

    # === Set prices to product variations.
    # Set prices to product variations.
    #
    # ==== Parameters
    # data:: (Hash) -- Data to be submited.
    #
    def set_prices_to_product_variations(data)
      return @client.raw("post", "/ecommerce/product-variations/set-prices", nil, data)
    end

    # === Get product from product variation.
    # Get a product from a product variation.
    #
    # ==== Parameters
    # productId:: (Integer) -- Product id.
    #
    def get_product_from_product_variation(productId)
      return @client.raw("get", "/ecommerce/product-variations/product/#{productId}")
    end

    # === Get product variations.
    # Get a collection of product variations.
    #
    # ==== Parameters
    # options:: (Hash) -- List of {Resource collection Options}[#class-Mints::User-label-Resource+collections+options+] shown above can be used as parameter.
    #
    def get_product_variations(options = nil)
      return @client.raw("get", "/ecommerce/product-variations", options)
    end

    # === Get product variation.
    # Get a product variation info.
    #
    # ==== Parameters
    # id:: (Integer) -- Product variation id.
    #
    def get_product_variation(id)
      return @client.raw("get", "/ecommerce/product-variations/#{id}")
    end

    # === Create product variation.
    # Create a product variation with data.
    #
    # ==== Parameters
    # data:: (Hash) -- Data to be submited.
    #
    def create_product_variation(data) #FIXME: Cannot validate price
      return @client.raw("post", "/ecommerce/product-variations", nil, data)
    end

    # === Update product variation.
    # Update a product variation info.
    #
    # ==== Parameters
    # id:: (Integer) -- Product variation id.
    # data:: (Hash) -- Data to be submited.
    #
    def update_product_variation(id, data) #TODO: Not tested
      return @client.raw("put", "/ecommerce/product-variations/#{id}", nil, data)
    end

    # === Delete product variation.
    # Delete a product variation.
    #
    # ==== Parameters
    # id:: (Integer) -- Product variation id.
    #
    def delete_product_variation(id) #TODO: Not tested
      return @client.raw("delete", "/ecommerce/product-variations/#{id}")
    end
    
    ##
    # == Variant Options
    #

    # === Get variant options.
    # Get a collection of variant options.
    #
    # ==== Parameters
    # options:: (Hash) -- List of {Resource collection Options}[#class-Mints::User-label-Resource+collections+options+] shown above can be used as parameter.
    #
    def get_variant_options(options = nil)
      return @client.raw("get", "/ecommerce/variant-options", options)
    end

    # === Get variant option.
    # Get a variant options info.
    #
    # ==== Parameters
    # id:: (Integer) -- Variant option id.
    # options:: (Hash) -- List of {Resource collection Options}[#class-Mints::User-label-Resource+collections+options+] shown above can be used as parameter.
    #
    def get_variant_option(id, options = nil)
      return @client.raw("get", "/ecommerce/variant-options/#{id}", options)
    end
    
    # === Create variant option.
    # Create a variant option with data.
    #
    # ==== Parameters
    # data:: (Hash) -- Data to be submited.
    #
    def create_variant_option(data)
      return @client.raw("post", "/ecommerce/variant-options", nil, data)
    end
    
    # === Update variant option.
    # Update a variant option info.
    #
    # ==== Parameters
    # id:: (Integer) -- Variant option id.
    # data:: (Hash) -- Data to be submited.
    #
    def update_variant_option(id, data)
      return @client.raw("put", "/ecommerce/variant-options/#{id}", nil, data)
    end
    
    # === Get can remove variant option.
    # Get info about if a variant option can be removed.
    #
    # ==== Parameters
    # id:: (Integer) -- Variant option id.
    #
    def get_can_remove_variant_option(id) #FIXME: VariantOptionController doesnt have canRemove method
      return @client.raw("get", "/ecommerce/variant-options/can-remove/#{id}")
    end

    ##
    # == Variant Values
    #
    
    # === Get variant values.
    # Get a collection of variant values.
    #
    # ==== Parameters
    # options:: (Hash) -- List of {Resource collection Options}[#class-Mints::User-label-Resource+collections+options+] shown above can be used as parameter.
    #
    def get_variant_values(options = nil)
      return @client.raw("get", "/ecommerce/variant-values", options)
    end
    
    # === Get variant value.
    # Get a variant value info.
    #
    # ==== Parameters
    # id:: (Integer) -- Variant value id.
    # options:: (Hash) -- List of {Resource collection Options}[#class-Mints::User-label-Resource+collections+options+] shown above can be used as parameter.
    #
    def get_variant_value(id, options = nil)
      return @client.raw("get", "/ecommerce/variant-values/#{id}", options)
    end

    # === Create variant value.
    # Create a variant value with data.
    #
    # ==== Parameters
    # data:: (Hash) -- Data to be submited.
    #
    def create_variant_value(data)
      return @client.raw("post", "/ecommerce/variant-values", nil, data)
    end

    # === Update variant value.
    # Update a variant value info.
    #
    # ==== Parameters
    # id:: (Integer) -- Variant value id.
    # data:: (Hash) -- Data to be submited.
    #
    def update_variant_value(id, data)
      return @client.raw("put", "/ecommerce/variant-values/#{id}", nil, data)
    end
    
    ##
    # == Product Templates
    #

    # === Get product templates support data from product.
    # Get product templates support data from a product.
    #
    # ==== Parameters
    # id:: (Integer) -- Product id.
    #
    def get_product_templates_support_data_from_product(id)
      return @client.raw("get", "/ecommerce/product-templates/support-data/products/#{id}")
    end

    # === Get product templates support data from order items group.
    # Get product templates support data from a order items group.
    #
    # ==== Parameters
    # id:: (Integer) -- Order items group id.
    #
    def get_product_templates_support_data_from_order_items_group(id)
      return @client.raw("get", "/ecommerce/product-templates/support-data/order-items-groups/#{id}")
    end

    # === Get product templates support data.
    # Get support data used in product templates.
    #
    # ==== Example
    #     @data = @mints_user.get_product_templates_support_data
    def get_product_templates_support_data
      return @client.raw("get", "/ecommerce/product-templates/support-data")
    end
    
    # === Get product templates.
    # Get a collection of product templates.
    #
    # ==== Parameters
    # options:: (Hash) -- List of {Resource collection Options}[#class-Mints::User-label-Resource+collections+options+] shown above can be used as parameter.
    #
    def get_product_templates(options = nil)
      return @client.raw("get", "/ecommerce/product-templates", options)
    end

    # === Get product template.
    # Get a product template info.
    #
    # ==== Parameters
    # id:: (Integer) -- Product template id.
    # options:: (Hash) -- List of {Resource collection Options}[#class-Mints::User-label-Resource+collections+options+] shown above can be used as parameter.
    #
    def get_product_template(id, options = nil)
      return @client.raw("get", "/ecommerce/product-templates/#{id}", options)
    end
    
    # === Create product template.
    # Create a product template with data.
    #
    # ==== Parameters
    # data:: (Hash) -- Data to be submited.
    #
    def create_product_template(data)
      return @client.raw("post", "/ecommerce/product-templates/", nil, data)
    end
    
    # === Update product template.
    # Update a product template info.
    #
    # ==== Parameters
    # id:: (Integer) -- Product template id.
    # data:: (Hash) -- Data to be submited.
    #
    def update_product_template(id, data)
      return @client.raw("put", "/ecommerce/product-templates/#{id}", nil, data)
    end

    ##
    # == Orders
    #

    # === Duplicate order.
    # Duplicate an order.
    #
    # ==== Parameters
    # orderId:: (Integer) -- Order id.
    # data:: (Hash) -- Data to be submited.
    #
    def duplicate_order(orderId, data) #FIXME: Doesnt read options from data and sale_price_cents column doesnt have to be null
      return @client.raw("post", "/ecommerce/orders/duplicate/#{orderId}", nil, data)
    end

    # === Delete orders.
    # Delete orders.
    #
    # ==== Parameters
    # data:: (Hash) -- Data to be submited.
    #
    def delete_orders(data) #TODO: Method should return another response like 'success'
      return @client.raw("delete", "/ecommerce/orders/delete", nil, data)
    end
    
    # === Get orders support data.
    # Get support data used in orders.
    #
    # ==== Example
    #     @data = @mints_user.get_orders_support_data
    def get_orders_support_data
      return @client.raw("get", "/ecommerce/orders/support-data")
    end
    
    # === Get orders.
    # Get a collection of orders.
    #
    # ==== Parameters
    # options:: (Hash) -- List of {Resource collection Options}[#class-Mints::User-label-Resource+collections+options+] shown above can be used as parameter.
    #
    def get_orders(options = nil)
      return @client.raw("get", "/ecommerce/orders", options)
    end

    # === Get order.
    # Get a order info.
    #
    # ==== Parameters
    # id:: (Integer) -- Order id.
    # options:: (Hash) -- List of {Resource collection Options}[#class-Mints::User-label-Resource+collections+options+] shown above can be used as parameter.
    #
    def get_order(id, options = nil)
      return @client.raw("get", "/ecommerce/orders/#{id}", options)
    end

    # === Create order.
    # Create a order with data.
    #
    # ==== Parameters
    # data:: (Hash) -- Data to be submited.
    #
    def create_order(data)
      return @client.raw("post", "/ecommerce/orders", nil, data)
    end

    # === Update order.
    # Update a order info.
    #
    # ==== Parameters
    # id:: (Integer) -- Order id.
    # data:: (Hash) -- Data to be submited.
    #
    def update_order(id, data)
      return @client.raw("put", "/ecommerce/orders/#{id}", nil, data)
    end
    
    ##
    # == Order Templates
    #
    
    # === Get order template support data.
    # Get support data from a order template.
    #
    # ==== Parameters
    # id:: (Integer) -- Order template id.
    #
    def get_order_template_support_data(id)
      return @client.raw("get", "/ecommerce/order-templates/support-data/#{id}")
    end

    # === Get order templates.
    # Get a collection of order templates.
    #
    # ==== Parameters
    # options:: (Hash) -- List of {Resource collection Options}[#class-Mints::User-label-Resource+collections+options+] shown above can be used as parameter.
    #
    def get_order_templates(options = nil)
      return @client.raw("get", "/ecommerce/order-templates", options)
    end

    # === Get order template.
    # Get a order template info.
    #
    # ==== Parameters
    # id:: (Integer) -- Order template id.
    # options:: (Hash) -- List of {Resource collection Options}[#class-Mints::User-label-Resource+collections+options+] shown above can be used as parameter.
    #
    def get_order_template(id, options = nil)
      return @client.raw("get", "/ecommerce/order-templates/#{id}", options)
    end
    
    # === Update order template.
    # Update a order template info.
    #
    # ==== Parameters
    # id:: (Integer) -- Order template id.
    # data:: (Hash) -- Data to be submited.
    #
    def update_order_templates(id, data)
      return @client.raw("put", "/ecommerce/order-templates/#{id}", nil, data)
    end

    ##
    # == Order Items
    #

    # === Get order items support data.
    # Get support data used in order items.
    #
    # ==== Example
    #     @data = @mints_user.get_order_items_support_data
    def get_order_items_support_data
      return @client.raw("get", "/ecommerce/order-items/support-data")
    end
    
    # === Detach order item from order item group.
    # Detach an order item from an order item group.
    #
    # ==== Parameters
    # orderItemId:: (Integer) -- Order item id.
    # groupId:: (Integer) -- Order items group id.
    #
    def detach_order_item_from_order_item_group(orderItemId, groupId) #TODO: Not tested
      return @client.raw("put", "/ecommerce/order-items/detach/#{orderItemId}/order-items-groups/#{groupId}")
    end

    # === Update order item from order item group.
    # Update an order item data from an order item group.
    #
    # ==== Parameters
    # orderItemId:: (Integer) -- Order item id.
    # groupId:: (Integer) -- Order items group id.
    #
    def update_order_item_from_order_item_group(orderItemId, groupId) #TODO: Not tested
      return @client.raw("put", "/ecommerce/order-items/update/#{orderItemId}/order-items-groups/#{groupId}")
    end
    
    # === Get order items.
    # Get a collection of order items.
    #
    # ==== Parameters
    # options:: (Hash) -- List of {Resource collection Options}[#class-Mints::User-label-Resource+collections+options+] shown above can be used as parameter.
    #
    def get_order_items(options = nil)
      return @client.raw("get", "/ecommerce/order-items", options)
    end

    # === Get order item.
    # Get a order item info.
    #
    # ==== Parameters
    # id:: (Integer) -- Order item id.
    # options:: (Hash) -- List of {Resource collection Options}[#class-Mints::User-label-Resource+collections+options+] shown above can be used as parameter.
    #
    def get_order_item(id, options = nil)
      return @client.raw("get", "/ecommerce/order-items/#{id}", options)
    end
    
    # === Update order item.
    # Update a order item info.
    #
    # ==== Parameters
    # id:: (Integer) -- Order item id.
    # data:: (Hash) -- Data to be submited.
    #
    def update_order_item(id, data) #TODO: Research what can update
      return @client.raw("put", "/ecommerce/order-items/#{id}", nil, data)
    end

    ##
    # == Order Items Groups
    #

    # === Get pending order template from order item group.
    # Get a pending order template from an order item group.
    #
    # ==== Parameters
    # parentOrderId:: (Integer) -- Order items group id.
    # orderTemplateId:: (Integer) -- Order template id.
    #
    def get_pending_order_template_from_order_item_group(parentOrderId, orderTemplateId)
      return @client.raw("get", "/ecommerce/order-items-groups/#{parentOrderId}/pending-items/order-template/#{orderTemplateId}")
    end
    
    def get_order_item_group_support_data_by_order_id(orderId)
      return @client.raw("get", "/ecommerce/order-items-groups/support-data/#{orderId}")
    end

    def get_order_item_groups(options = nil)
      return @client.raw("get", "/ecommerce/order-items-groups", options)
    end

    def get_order_item_group(id, options = nil)
      return @client.raw("get", "/ecommerce/order-items-groups/#{id}", options)
    end
    
    def create_order_item_group(data)
      return @client.raw("post", "/ecommerce/order-items-groups", nil, data)
    end
    
    def update_order_item_group(id, data)
      return @client.raw("put", "/ecommerce/order-items-groups/#{id}", nil, data)
    end
    
    def delete_order_item_group(id)
      return @client.raw("delete", "/ecommerce/order-items-groups/#{id}")
    end

    ##
    # == Order Statuses
    #

    def get_order_statuses
      return @client.raw("get", "/ecommerce/order-statuses")
    end
    
    def get_order_status(id)
      return @client.raw("get", "/ecommerce/order-statuses/#{id}")
    end

    ##
    # == Item Prices
    #

    def get_item_prices(options = nil)
      return @client.raw("get", "/ecommerce/item-prices", options)
    end

    def get_item_price(id, options = nil)
      return @client.raw("get", "/ecommerce/item-prices/#{id}", options)
    end

    def create_item_price(data) #FIXME: DB Error: sku_id cannot be null
      return @client.raw("post", "/ecommerce/item-prices", nil, data)
    end

    def update_item_price(id, data)
      return @client.raw("put", "/ecommerce/item-prices/#{id}", nil, data)
    end
    
    def delete_item_price(id)
      return @client.raw("delete", "/ecommerce/item-prices/#{id}")
    end

    ##
    # == Sku
    #

    def get_skus(options = nil)
      return @client.raw("get", "/ecommerce/skus", options)
    end
    
    def get_sku(id, options = nil)
      return @client.raw("get", "/ecommerce/skus/#{id}", options)
    end

    def create_sku(data)
      return @client.raw("post", "/ecommerce/skus", nil, data)
    end
    
    def update_sku(id, data)
      return @client.raw("put", "/ecommerce/skus/#{id}", nil, data)
    end
    
    def delete_sku(id)
      return @client.raw("delete", "/ecommerce/skus/#{id}")
    end
    
    ##
    # == Taxes
    #

    def get_taxes(options = nil)
      return @client.raw("get", "/ecommerce/taxes", options)
    end

    def get_tax(id, options = nil)
      return @client.raw("get", "/ecommerce/taxes/#{id}", options)
    end
    
    def create_tax(data)
      return @client.raw("post", "/ecommerce/taxes", nil, data)
    end
    
    def update_tax(id, data)
      return @client.raw("put", "/ecommerce/taxes/#{id}", nil, data)
    end
    
    def delete_tax(id)
      return @client.raw("delete", "/ecommerce/taxes/#{id}")
    end


    ######################################### Config #########################################


    ##
    # == Importers
    #

    def get_importers_results(options = nil)
      return @client.raw("get", "/config/importers/results", options)
    end
    
    def get_importers_configuration
      return @client.raw("get", "/config/importers/configuration")
    end

    def get_importing_process_status(options = nil)
      return @client.raw("get", "/config/importers/importing_process_status", options)
    end

    def get_importers_attributes(options = nil)
      return @client.raw("get", "/config/importers/attributes", options)
    end

    def upload_importer(id, data) #TODO: Search for csv archives
      return @client.raw("post", "/config/importers/#{id}/upload", nil, data)
    end

    def import_row(data) #TODO: Research use
      return @client.raw("post", "/config/importers/import_row", nil, data)
    end
    
    def remove_importers_active_process(data)
      return @client.raw("post", "/config/importers/removeActiveProcess", nil, data)
    end
    
    def get_importers(options = nil)
      return @client.raw("get", "/config/importers", options)
    end

    def get_importer(id, options = nil)
      return @client.raw("get", "/config/importers/#{id}", options)
    end

    def create_importer(data)
      return @client.raw("post", "/config/importers", nil, data)
    end

    def update_importer(id, data)
      return @client.raw("put", "/config/importers/#{id}", nil, data)
    end

    def delete_importer(id)
      return @client.raw("delete", "/config/importers/#{id}")
    end
    
    def get_importers_pusher_key
      return @client.raw("get", "/config/pusher_key")
    end

    ##
    # == Attributes
    #

    def get_attributes_data_types
      return @client.raw("get", "/config/attributes/data-types")
    end
    
    def get_attributes
      return @client.raw("get", "/config/attributes")
    end
    
    def get_attribute(id)
      return @client.raw("get", "/config/attributes/#{id}")
    end

    def create_attribute(data)
      return @client.raw("post", "/config/attributes", nil, data)
    end

    def update_attribute(id, data)
      return @client.raw("put", "/config/attributes/#{id}", nil, data)
    end

    ##
    # == Attribute Groups
    #

    def get_attribute_groups_data_types
      return @client.raw("get", "/config/attribute-groups/object-types")
    end

    def get_attribute_groups(options = nil)
      return @client.raw("get", "/config/attribute-groups", options)
    end
    
    def get_attribute_group(id)
      return @client.raw("get", "/config/attribute-groups/#{id}")
    end

    def create_attribute_group(data)
      return @client.raw("post", "/config/attribute-groups", nil, data)
    end

    def update_attribute_group(id, data)
      return @client.raw("put", "/config/attribute-groups/#{id}", nil, data)
    end

    ##
    # == Categories
    #

    def sync_categories_for_object(data)
      return @client.raw("put", "/config/categories/sync_categories_for_object", nil, data)
    end

    def get_categories_for_object(options)
      return @client.raw("get", "/config/categories/get_categories_for_object", options)
    end
    
    def get_categories
      return @client.raw("get", "/config/categories")
    end

    def create_category(data) #TODO: Research if 'visible' is a boolean or int. It accepts smallint
      return @client.raw("post", "/config/categories", nil, data)
    end

    def update_category(id, data)
      return @client.raw("put", "/config/categories/#{id}", nil, data)
    end

    def get_category_support_data(id)
      return @client.raw("get", "/config/categories/support-data/#{id}")
    end
    
    def get_category(id)
      return @client.raw("get", "/config/categories/#{id}")
    end

    ##
    # == Taxonomies
    #

    def sync_taxonomies_for_object(data)
      return @client.raw("put", "/config/taxonomies/sync_taxonomies_for_object", nil, data)
    end

    def get_taxonomies_for_object(options)
      return @client.raw("get", "/config/taxonomies/get_taxonomies_for_object", options)
    end
    
    def get_taxonomies_support_data
      return @client.raw("get", "/config/taxonomies/support-data")
    end
    
    def get_ui_taxonomy(id)
      return @client.raw("get", "/config/taxonomies/ui-taxonomies/#{id}")
    end
    
    def get_taxonomies(options = nil)
      return @client.raw("get", "/config/taxonomies", options)
    end

    def get_taxonomy(id, options = nil)
      return @client.raw("get", "/config/taxonomies/#{id}", options)
    end

    def create_taxonomy(data)
      return @client.raw("post", "/config/taxonomies", nil, data)
    end
    
    def update_taxonomy(id, data)
      return @client.raw("put", "/config/taxonomies/#{id}", nil, data)
    end
    
    ##
    # == Relationships
    #
    
    def get_relationships_available_for(options)
      return @client.raw("get", "/config/relationships/available-for", options)
    end
    
    def attach_relationship(data) #FIXME: Method doesn't work, controller cannot get data from request variable.
      return @client.raw("post", "/config/relationships/attach", nil, data)
    end

    def detach_relationship(data) #FIXME: Undefined index. Can correct
      return @client.raw("post", "/config/relationships/detach", nil, data)
    end
    
    def relationship_has_objects(id)
      return @client.raw("get", "/config/relationships/#{id}/hasObjects")
    end
    
    def get_relationships(options = nil)
      return @client.raw("get", "/config/relationships", options)
    end

    def get_relationship(id, options = nil)
      return @client.raw("get", "/config/relationships/#{id}", options)
    end

    def create_relationship(data)
      return @client.raw("post", "/config/relationships", nil, data)
    end

    def update_relationship(id, data)
      return @client.raw("put", "/config/relationships/#{id}", nil, data)
    end

    def delete_relationship(id)
      return @client.raw("delete", "/config/relationships/#{id}")
    end

    ##
    # == Tags
    #

    def get_tags
      return @client.raw("get", "/config/tags")
    end

    def get_tag(id)
      return @client.raw("get", "/config/tags/#{id}")
    end

    def create_tag(data)
      return @client.raw("post", "/config/tags", nil, data)
    end

    def update_tag(id, data) #FIXME: Method doesn't work, controller cannot get data from request variable.
      return @client.raw("put", "/config/tags/#{id}", nil, data)
    end

    ##
    # == Roles
    #

    def get_roles_permissions #FIXME: RoleController doesnt have getPermissions method
      return @client.raw("get", "/config/roles/get-permissions")
    end

    def duplicate_role(id, data)
      return @client.raw("post", "/config/roles/#{id}/duplicate", nil, data)
    end
    
    def get_roles
      return @client.raw("get", "/config/roles")
    end

    def get_role(id)
      return @client.raw("get", "/config/roles/#{id}")
    end

    def create_role(data)
      return @client.raw("post", "/config/roles", nil, data)
    end
    
    def update_role(id, data)
      return @client.raw("put", "/config/roles/#{id}", nil, data)
    end

    ##
    # == Users
    #

    ##
    # === Can Users Coach.
    # Determine if users can coach.
    #
    # ==== Example
    #     @data = @mints_user.can_users_coach
    def can_users_coach
      return @client.raw("get", "/config/users/can_coach")
    end

    def get_users
      return @client.raw("get", "/config/users")
    end

    def get_user(id)
      return @client.raw("get", "/config/users/#{id}")
    end
    
    def create_user(data)
      return @client.raw("post", "/config/users", nil, data)
    end

    def update_user(id, data)
      return @client.raw("put", "/config/users/#{id}", nil, data)
    end

    ##
    # == Teams
    #
    
    def get_team_types
      return @client.raw("get", "/config/teams/team-types")
    end
    
    def get_teams
      return @client.raw("get", "/config/teams")
    end
    
    def get_team(id)
      return @client.raw("get", "/config/teams/#{id}")
    end

    def create_team(data)
      return @client.raw("post", "/config/teams", nil, data)
    end
    
    def update_team(id, data)
      return @client.raw("put", "/config/teams/#{id}", nil, data)
    end

    ##
    # == Api keys
    #
    
    def get_api_keys(options = nil)
      return @client.raw("get", "/config/api-keys", options)
    end

    def get_api_key(id, options = nil)
      return @client.raw("get", "/config/api-keys/#{id}", options)
    end

    def create_api_key(data)
      return @client.raw("post", "/config/api-keys", nil, data)
    end

    def delete_api_key(id)
      return @client.raw("delete", "/config/api-keys/#{id}")
    end

    ##
    # == System Settings
    #

    def get_settings_by_keys(options)
      return @client.raw("get", "/config/settings/by-keys", options)
    end
    
    def get_settings
      return @client.raw("get", "/config/settings")
    end      

    def create_setting(data)
      return @client.raw("post", "/config/settings", nil, data)
    end

    ##
    # == Seeds
    #

    def apply_seeds(data) #TODO: Research use
      return @client.raw("post", "/config/seeds", nil, data)
    end


    ######################################### Profile #########################################


    ##
    # === Me.
    # Get contact logged info
    #

    def me
      return @client.raw("get", "/profile/me")
    end

    ##
    # == User Preferences
    #

    def get_preferences
      return @client.raw("get", "/profile/preferences")
    end
    
    def create_preferences(data)
      return @client.raw("post", "/profile/preferences", nil, data)
    end

    def get_preferences_by_setting_key(setting_key)
      return @client.raw("get", "/profile/preferences/#{setting_key}")
    end

    ##
    # == Notifications
    #

    def get_notifications
      return @client.raw("get", "/profile/notifications")
    end

    def get_paginated_notifications
      return @client.raw("get", "/profile/notificationsp")
    end

    def read_notifications(data)
      return @client.raw("post", "/profile/notifications/read", nil, data)
    end
    
    def delete_notifications(data)
      return @client.raw("post", "/profile/notifications/delete", nil, data)
    end


    ######################################### Helpers #########################################


    ##
    # == Helpers
    #
    
    def slugify(options)
      return @client.raw("get", "/helpers/slugify", options)
    end
    
    def get_available_types_from_usage(usage) #TODO: Research use
      return @client.raw("get", "/helpers/available-types/#{usage}")
    end

    def get_magic_link_config
      return @client.raw("get", "/helpers/magic-link-config")
    end

    ##
    # == User Folders
    #

    def get_user_folders(options = nil)
      return @client.raw("get", "/helpers/folders", options)
    end

    def get_user_folder(id, options = nil)
      return @client.raw("get", "/helpers/folders/#{id}", options)
    end

    def create_user_folder(data)
      return @client.raw("post", "/helpers/folders", nil, data)
    end

    def update_user_folder(id, data)
      return @client.raw("put", "/helpers/folders/#{id}", nil, data)
    end

    def delete_user_folder(id)
      return @client.raw("delete", "/helpers/folders/#{id}")
    end

    ##
    # == Object Folders
    #

    def get_object_folders(options = nil)
      return @client.raw("get", "/helpers/object-folders", options)
    end

    def get_object_folder(id, options = nil)
      return @client.raw("get", "/helpers/object-folders/#{id}", options)
    end

    def create_object_folder(data)
      return @client.raw("post", "/helpers/object-folders", nil, data)
    end

    def update_object_folder(id, data)
      return @client.raw("put", "/helpers/object-folders/#{id}", nil, data)
    end

    def delete_object_folder(id)
      return @client.raw("delete", "/helpers/object-folders/#{id}")
    end

    ##
    # == Object Activities
    #

    def get_object_activities(options = nil)
      return @client.raw("get", "/helpers/object-activities", options)
    end

    def get_object_activity(id, options = nil)
      return @client.raw("get", "/helpers/object-activities/#{id}", options)
    end

    def create_object_activity(data)
      return @client.raw("post", "/helpers/object-activities", nil, data)
    end
    
    def update_object_activity(id, data)
      return @client.raw("put", "/helpers/object-activities/#{id}", nil, data)
    end

    def delete_object_activity(id)
      return @client.raw("delete", "/helpers/object-activities/#{id}")
    end
    
    ##
    # == Activities
    #

    def get_activities_by_object_type_and_id(object_type, id)
      return @client.raw("get", "/helpers/activities/#{object_type}/#{id}")
    end

    ##
    # == Dice Coefficient
    #
    
    def get_dice_coefficient(options)
      return @client.raw("get", "/helpers/dice-coefficient", options)
    end

    ##
    # == Permission
    #

    def get_permission_menu
      return @client.raw("get", "/helpers/menu")
    end
    

    ######################################### Contacts #########################################


    ##
    # == Contact Auth
    #
    
    def change_password_no_auth(data)
      return @client.raw("post", "/contacts/change-password-no-auth", nil, data)
    end

    private

    def get_query_results(url, options = nil, use_post = true)
      if use_post
        return @client.raw("post", "#{url}/query", options)
      else
        return @client.raw("get", url, options)
      end
    end

    def data_transform(data)
      data = correct_json(data)
      unless data[:data]
        data = {data: data}
      end
      return data
    end

    def correct_json(data)
      if data.is_a? String
        data = JSON.parse(data)
        data = data.symbolize_keys
      end
      return data
    end
    
  end  
end
