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
      response = @client.raw("post", "/users/login", nil, data.to_json, '/api/v1', {'no_content_type': true})
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
    #     @data = @mints_user.create_contact_deal(5, data.to_json)
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
    #     @data = @mints_user.create_contact_user(66, data.to_json)
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
    #     @data = @mints_user.create_deal(data.to_json)
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
    #     @data = @mints_user.update_deal(102, data.to_json)
    def update_deal(id, data)
      return @client.raw("put", "/crm/deals/#{id}", nil, data)
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
    #     @data = @mints_user.create_workflow(data.to_json)
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
    #     @data = @mints_user.update_step_object(128, data.to_json)
    def update_step_object(id, data)
      return @client.raw("put", "/crm/step-objects/#{id}", nil, data)
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
    #     @data = @mints_user.create_workflow_step(data.to_json)
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
    #     data = { 
    #       "stepTitle": "Step Title Modified"
    #     }
    #     @data = @mints_user.update_workflow_step(23, data)
    def update_workflow_step(id, data)
      return @client.raw("put", "/crm/steps/#{id}", nil, data)
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
    # === Get crm users.
    # Get users info in crm.
    #
    # ==== Parameters
    # options:: (Hash) -- List of {Resource collection Options}[#class-Mints::User-label-Resource+collections+options+] shown above can be used as parameter.
    #
    # ==== First Example
    #     @data = @mints_user.get_crm_users
    #
    # ==== Second Example
    #     options = { "sort": "id", "fields": "id, email" }
    #     @data = @mints_user.get_crm_users(options)
    def get_crm_users(options = nil)
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
    #     @data = @mints_user.update_page(5, data.to_json)
    def update_page(id, data)
      return @client.raw("put", "/content/pages/#{id}", nil, data)
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
    def publish_form(id, data) #FIXME: Output cannot be processed. response cannot be converted to json.
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
    def schedule_form(id, data) #FIXME: Output cannot be processed. response cannot be converted to json.
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
    def revert_published_form(id)
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
    #     @data = @mints_user.create_content_template(data.to_json)
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
    #     @data = @mints_user.update_content_template(7, data.to_json)
    def update_content_template(id, data)
       #TODO: Inform ContentTemplateController.update method has been modified
      return @client.raw("put", "/content/templates/#{id}", nil, data)
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
    #     @data = @mints_user.duplicate_content_instance(1, data.to_json)
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
    #     @data = @mints_user.rename_dam(data.to_json)
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
    #     @data = @mints_user.search_dam(data.to_json)
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
    #       "folder_name": "New Dam Folder",
    #       "slug": "new-dam-folder"
    #     }
    #     @data = @mints_user.create_dam_folder(data.to_json)
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
    #     data = { 
    #       "link": "https://www.example.com/img/img.jpg"
    #     }
    #     @data = @mints_user.get_asset_link_info(data.to_json)
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
    #     @data = @mints_user.duplicate_story(1, data.to_json)
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
      return @client.raw("post", "/content/message-templates/#{id}/duplicate", nil, data_transform(data))
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
    #       "slug": "new-message-template"
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
    #       "title": "New Message Template Modified"
    #     }
    #     @data = @mints_user.update_message_template(5, data)
    def update_message_template(id, data)
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
    # ==== Example
    #     data = {
    #       "title": "New Keyword"
    #     }
    #     @data = @mints_user.create_keyword(data.to_json)
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
    # ==== Example
    #     data = {
    #       "keyword": {
    #         "title": "New Keyword Modified"
    #       }
    #     }
    #     @data = @mints_user.update_keyword(2, data.to_json)
    def update_keyword(id, data)
      #TODO: Inform KeywordController.update method has been modified
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
    # ==== Example
    #     @data = @mints_user.get_author(1)
    def get_author(id)
      return @client.raw("get", "/content/authors/#{id}")
    end

    # === Create author.
    # Create an author with data.
    #
    # ==== Parameters
    # data:: (Hash) -- Data to be submited.
    #
    # ==== Example
    #     data = {
    #       "title": "Howard Phillips Lovecraft",
    #       "slug": "howard-phillips-lovecraft"
    #     }
    #     @data = @mints_user.create_author(data.to_json)
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
    # ==== Example
    #     data = {
    #       "author": {
    #         "title": "Howard Phillips Lovecraft Modified",
    #         "slug": "howard-phillips-lovecraft"
    #       }
    #     }
    #     @data = @mints_user.update_author(2, data.to_json)
    def update_author(id, data)
      #TODO: Inform AuthorController.update method has been modified
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
    # ==== Example
    #     @data = @mints_user.get_stage(1)
    def get_stage(id)
      return @client.raw("get", "/content/stages/#{id}")
    end

    # === Create stage.
    # Create a stage with data.
    #
    # ==== Parameters
    # data:: (Hash) -- Data to be submited.
    #
    # ==== Example
    #     config_json = {
    #       "count": 1
    #     }
    #     event_json = {
    #       "rset": "DTSTART:20190214T000000Z",
    #       "duration": 1
    #     }
    #     data = {
    #       "title": "New Stage",
    #       "description": "New Stage Description",
    #       "config_json": config_json.to_json,
    #       "event_json": event_json.to_json
    #     }
    #     @data = @mints_user.create_stage(data.to_json)
    def create_stage(data)
      return @client.raw("post", "/content/stages", nil, data)
    end

    # === Update stage.
    # Update a stage info.
    #
    # ==== Parameters
    # id:: (Integer) -- Stage id.
    # data:: (Hash) -- Data to be submited.
    #
    # ==== Example
    #     config_json = {
    #       "count": 2
    #     }
    #     event_json = {
    #       "rset": "DTSTART:20190214T000000Z",
    #       "duration": 2
    #     }
    #     data = {
    #       "stageProps": { 
    #         "title": "New Stage Modified",
    #         "description": "New Stage Description Modified"
    #       },
    #       "config_json": config_json.to_json,
    #       "event_json": event_json.to_json
    #     }
    #     @data = @mints_user.update_stage(3, data.to_json)
    def update_stage(id, data)
      #TODO: Inform StageController.update method has been modified
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
    # ==== First Example
    #     @data = @mints_user.get_automations
    #
    # ==== Second Example
    #       options = {
    #         "fields": "title"
    #       }
    #       @data = @mints_user.get_automations(options)
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
    # ==== First Example
    #     @data = @mints_user.get_automation(1)
    #
    # ==== Second Example
    #     options = {
    #       "fields": "title, id"
    #     }
    #     @data = @mints_user.get_automation(1, options)
    def get_automation(id, options = nil)
      return @client.raw("get", "/marketing/automation/#{id}", options)
    end

    # === Create automation.
    # Create an automation with data.
    #
    # ==== Parameters
    # data:: (Hash) -- Data to be submited.
    #
    # ==== Example
    #     data = {
    #       "title": "New Automation"
    #     }
    #     @data = @mints_user.create_automation(data)
    def create_automation(data)
      return @client.raw("post", "/marketing/automation/", nil, data_transform(data))
    end

    # === Update automation.
    # Update an automation info.
    #
    # ==== Parameters
    # id:: (Integer) -- Automation id.
    # data:: (Hash) -- Data to be submited.
    #
    def update_automation(id, data) #FIXME: Method doesn't work.
      return @client.raw("put", "/marketing/automation/#{id}", nil, data_transform(data))
    end

    # === Delete automation.
    # Delete an automation.
    #
    # ==== Parameters
    # id:: (Integer) -- Automation id.
    #
    # ==== Example
    #     @data = @mints_user.delete_automation(5)
    def delete_automation(id)
      return @client.raw("delete", "/marketing/automation/#{id}")
    end

    # === Get automation executions.
    # Get executions of an automation.
    #
    # ==== Parameters
    # id:: (Integer) -- Automation id.
    #
    # ==== Example
    #     @data = @mints_user.get_automation_executions(1)
    def get_automation_executions(id)
      return @client.raw("get", "/marketing/automation/#{id}/executions")
    end
    
    # === Reset automation.
    # Reset an automation.
    #
    # ==== Parameters
    # id:: (Integer) -- Automation id.
    #
    # ==== Example
    #     @data = @mints_user.reset_automation(1)
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
    # ==== Example
    #     data = {
    #       "options": [] 
    #     }
    #     @data = @mints_user.duplicate_automation(1, data.to_json)
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
    # ==== First Example
    #     @data = @mints_user.get_price_lists
    #
    # ==== Second Example
    #     options = {
    #       "fields": "title"
    #     }
    #     @data = @mints_user.get_price_lists(options)
    def get_price_lists(options = nil)
      return get_query_results("/ecommerce/price-list", options)
    end

    # === Get price list.
    # Get a price list info.
    #
    # ==== Parameters
    # id:: (Integer) -- Price list id.
    # options:: (Hash) -- List of {Resource collection Options}[#class-Mints::User-label-Resource+collections+options+] shown above can be used as parameter.
    #
    # ==== First Example
    #     @data = @mints_user.get_price_list(1)
    #
    # ==== Second Example
    #     options = {
    #       "fields": "title"
    #     }
    #     @data = @mints_user.get_price_list(1, options)
    def get_price_list(id, options = nil)
      return @client.raw("get", "/ecommerce/price-list/#{id}", options)
    end

    # === Create price list.
    # Create a price list with data.
    #
    # ==== Parameters
    # data:: (Hash) -- Data to be submited.
    #
    # ==== Example
    #     data = {
    #       "title": "New Price List"
    #     }
    #     @data = @mints_user.create_price_list(data)
    def create_price_list(data)
      return @client.raw("post", "/ecommerce/price-list", nil, data_transform(data))
    end

    # === Update price list.
    # Update a price list info.
    #
    # ==== Parameters
    # id:: (Integer) -- Price list id.
    # data:: (Hash) -- Data to be submited.
    #
    # ==== Example
    #     data = {
    #       "title": "New Price List Modified"
    #     }
    #     @data = @mints_user.update_price_list(8, data)
    def update_price_list(id, data)
      return @client.raw("put", "/ecommerce/price-list/#{id}", nil, data_transform(data))
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
    def update_product_variations_config(productId, data) #TODO: Method doesnt work, research use
      return @client.raw("post", "/ecommerce/products/update-variations-config/#{productId}", nil, data_transform(data))
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
    # ==== Example
    #     data = {
    #       "title": "New Publish"
    #     }
    #     @data = @mints_user.publish_product(2, data)
    def publish_product(id, data)
      return @client.raw("put", "/ecommerce/products/#{id}/publish", nil, data_transform(data))
    end

    # === Schedule product.
    # Schedule a product.
    #
    # ==== Parameters
    # id:: (Integer) -- Product id.
    # data:: (Hash) -- Data to be submited.
    #
    # ==== Example
    #     data = {
    #       "scheduled_at": "1970-01-01 00:00:00"
    #     }
    #     @data = @mints_user.schedule_product(2, data)
    def schedule_product(id, data)
      return @client.raw("put", "/ecommerce/products/#{id}/schedule", nil, data_transform(data))
    end

    # === Get product variant options config.
    # Get variant options config used in a product.
    #
    # ==== Parameters
    # id:: (Integer) -- Product id.
    #
    # ==== Example
    #     @data = @mints_user.get_product_variant_options_config(1)
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
    # use_post:: (Boolean) -- Variable to determine if the request is by 'post' or 'get' functions.
    #
    # ==== First Example
    #     @data = @mints_user.get_products
    #
    # ==== Second Example
    #     options = {
    #       "fields": "id"
    #     }
    #     @data = @mints_user.get_products(options)
    #
    # ==== Third Example
    #     options = {
    #       "fields": "id"
    #     }
    #     @data = @mints_user.get_products(options, false)
    def get_products(options = nil, use_post = true)
      return get_query_results("/ecommerce/products", options, use_post)
    end

    # === Get product.
    # Get a product info.
    #
    # ==== Parameters
    # id:: (Integer) -- Product id.
    # options:: (Hash) -- List of {Resource collection Options}[#class-Mints::User-label-Resource+collections+options+] shown above can be used as parameter.
    #
    # ==== First Example
    #     @data = @mints_user.get_product(3)
    #
    # ==== Second Example
    #     options = {
    #       "fields": "slug"
    #     }
    #     @data = @mints_user.get_product(3, options)
    def get_product(id, options = nil)
      return @client.raw("get", "/ecommerce/products/#{id}", options)
    end

    # === Create product.
    # Create a product with data.
    #
    # ==== Parameters
    # data:: (Hash) -- Data to be submited.
    #
    # ==== Example
    #     data = {
    #       "title": "New Product",
    #       "slug": "new-product",
    #       "sku_prefix": "sku_prefix"
    #     }
    #     @data = @mints_user.create_product(data)
    def create_product(data)
      return @client.raw("post", "/ecommerce/products/", nil, data_transform(data))
    end

    # === Update product.
    # Update a product info.
    #
    # ==== Parameters
    # id:: (Integer) -- Product id.
    # data:: (Hash) -- Data to be submited.
    #
    # ==== Example
    #     data = {
    #       "title": "New Product Modified",
    #       "slug": "new-product"
    #     }
    #     @data = @mints_user.update_product(9, data)
    def update_product(id, data)
      return @client.raw("put", "/ecommerce/products/#{id}", nil, data_transform(data))
    end
    
    ##
    # == Locations
    #

    # === Get locations.
    # Get a collection of locations.
    #
    # ==== Parameters
    # use_post:: (Boolean) -- Variable to determine if the request is by 'post' or 'get' functions.
    #
    # ==== First Example
    #     @data = @mints_user.get_locations
    #
    # ==== Second Example
    #     @data = @mints_user.get_locations(false)
    def get_locations(use_post = true)
      return get_query_results("/ecommerce/locations", nil, use_post)
    end
    
    # === Get location.
    # Get a location info.
    #
    # ==== Parameters
    # id:: (Integer) -- Location id.
    #
    # ==== Example
    #     @data = @mints_user.get_location(2)
    def get_location(id)
      return @client.raw("get", "/ecommerce/locations/#{id}")
    end

    # === Create location.
    # Create a location with data.
    #
    # ==== Parameters
    # data:: (Hash) -- Data to be submited.
    #
    # ==== Example
    #     data = {
    #       "title": "New Location",
    #       "location_template_id": 1
    #     }
    #     @data = @mints_user.create_location(data)
    def create_location(data)
      return @client.raw("post", "/ecommerce/locations", nil, data_transform(data))
    end

    # === Update location.
    # Update a location info.
    #
    # ==== Parameters
    # id:: (Integer) -- Location id.
    # data:: (Hash) -- Data to be submited.
    #
    # ==== Example
    #     data = {
    #       "title": "New Location Modified"
    #     }
    #     @data = @mints_user.update_location(5, data.to_json)
    def update_location(id, data)
      return @client.raw("put", "/ecommerce/locations/#{id}", nil, data)
    end

    # === Delete location.
    # Delete a location.
    #
    # ==== Parameters
    # id:: (Integer) -- Location id.
    #
    # ==== Example
    #     @data = @mints_user.delete_location(5)
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
    # ==== Example
    #     @data = @mints_user.get_location_template_support_data(1)
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
    # ==== First Example
    #     @data = @mints_user.get_location_templates
    #
    # ==== Second Example
    #     options = { "fields": "title" }
    #     @data = @mints_user.get_location_templates(options)
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
    # ==== First Example
    #     @data = @mints_user.get_location_template(1)
    #
    # ==== Second Example
    #     options = { "fields": "title" }
    #     @data = @mints_user.get_location_template(1, options)
    def get_location_template(id, options = nil)
      return @client.raw("get", "/ecommerce/location-templates/#{id}", options)
    end
    
    # === Create location template.
    # Create a location template with data.
    #
    # ==== Parameters
    # data:: (Hash) -- Data to be submited.
    #
    # ==== Example
    #     data = {
    #       "title": "New Location Template",
    #       "slug": "new-location-template"
    #     }
    #     @data = @mints_user.create_location_template(data)
    def create_location_template(data)
      return @client.raw("post", "/ecommerce/location-templates", nil, data_transform(data))
    end
    
    # === Update location template.
    # Update a location template info.
    #
    # ==== Parameters
    # id:: (Integer) -- Location template id.
    # data:: (Hash) -- Data to be submited.
    #
    # ==== Example
    #     data = {
    #       "title": "New Location Template Modified"
    #     }
    #     @data = @mints_user.update_location_template(3, data)
    def update_location_template(id, data)
      return @client.raw("put", "/ecommerce/location-templates/#{id}", nil, data_transform(data))
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
    def generate_product_variation(productId, data) #TODO: Research use
      #TODO: Notify line 247 had a '/' before Exception
      return @client.raw("post", "/ecommerce/product-variations/generate/#{productId}", nil, data_transform(data))
    end

    # === Set prices to product variations.
    # Set prices to product variations.
    #
    # ==== Parameters
    # data:: (Hash) -- Data to be submited.
    #
    # ==== Example
    #     skus = [
    #       { "id": 100 }
    #     ]
    #     prices = [
    #       { "id": 1, "value": 1259 },
    #       { "id": 2, "value": 1260 }
    #     ]
    #     data = {
    #       "skus": skus.to_json,
    #       "prices": prices.to_json
    #     }
    #     @data = @mints_user.set_prices_to_product_variations(data)
    def set_prices_to_product_variations(data)
      return @client.raw("post", "/ecommerce/product-variations/set-prices", nil, data_transform(data))
    end

    # === Get product from product variation.
    # Get a product from a product variation.
    #
    # ==== Parameters
    # productId:: (Integer) -- Product id.
    #
    # ==== Example
    #     @data = @mints_user.get_product_from_product_variation(1)
    def get_product_from_product_variation(productId)
      return @client.raw("get", "/ecommerce/product-variations/product/#{productId}")
    end

    # === Get product variations.
    # Get a collection of product variations.
    #
    # ==== Parameters
    # options:: (Hash) -- List of {Resource collection Options}[#class-Mints::User-label-Resource+collections+options+] shown above can be used as parameter.
    #
    # ==== Example
    #     @data = @mints_user.get_product_variations
    def get_product_variations
      return @client.raw("get", "/ecommerce/product-variations")
    end

    # === Get product variation.
    # Get a product variation info.
    #
    # ==== Parameters
    # id:: (Integer) -- Product variation id.
    #
    # ==== Example
    #     @data = @mints_user.get_product_variation(100)
    def get_product_variation(id)
      return @client.raw("get", "/ecommerce/product-variations/#{id}")
    end

    # === Create product variation.
    # Create a product variation with data.
    #
    # ==== Parameters
    # data:: (Hash) -- Data to be submited.
    #
    # ==== Example
    #     data = {
    #       "title": "New Product Variation",
    #       "sku": "NEW-PRODUCT-VARIATION-SKU",
    #       "product_id": 5,
    #       "supplier": 36,
    #       "prices": [
    #         { "id": 1, "value": 300 }
    #       ]
    #     }
    #     @data = @mints_user.create_product_variation(data)
    def create_product_variation(data)
      return @client.raw("post", "/ecommerce/product-variations", nil, data_transform(data))
    end

    # === Update product variation.
    # Update a product variation info.
    #
    # ==== Parameters
    # id:: (Integer) -- Product variation id.
    # data:: (Hash) -- Data to be submited.
    #
    # ==== Example
    #     data = {
    #       "title": "New Product Variation Modified",
    #       "cost": 123,
    #       "prices": [
    #         { "id": 1, "value": 400 }
    #       ]
    #     }
    #     @data = @mints_user.update_product_variation(528, data)
    def update_product_variation(id, data)
      return @client.raw("put", "/ecommerce/product-variations/#{id}", nil, data_transform(data))
    end

    # === Delete product variation.
    # Delete a product variation.
    #
    # ==== Parameters
    # id:: (Integer) -- Product variation id.
    #
    # ==== Example
    #     @data = @mints_user.delete_product_variation(528)
    def delete_product_variation(id)
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
    # ==== First Example
    #     @data = @mints_user.get_variant_options
    #
    # ==== Second Example
    #     options = { "fields": "id, title" }
    #     @data = @mints_user.get_variant_options(options)
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
    # ==== First Example
    #     @data = @mints_user.get_variant_option(1)
    #
    # ==== Second Example
    #     options = { "fields": "id, title" }
    #     @data = @mints_user.get_variant_option(1, options)
    def get_variant_option(id, options = nil)
      return @client.raw("get", "/ecommerce/variant-options/#{id}", options)
    end
    
    # === Create variant option.
    # Create a variant option with data.
    #
    # ==== Parameters
    # data:: (Hash) -- Data to be submited.
    #
    # ==== Example
    #     data = {
    #       "title": "New Variant Option"
    #     }
    #     @data = @mints_user.create_variant_option(data)
    def create_variant_option(data)
      return @client.raw("post", "/ecommerce/variant-options", nil, data_transform(data))
    end
    
    # === Update variant option.
    # Update a variant option info.
    #
    # ==== Parameters
    # id:: (Integer) -- Variant option id.
    # data:: (Hash) -- Data to be submited.
    #
    # ==== Example
    #     data = {
    #       "title": "New Variant Option Modified"
    #     }
    #     @data = @mints_user.update_variant_option(6, data)
    def update_variant_option(id, data)
      return @client.raw("put", "/ecommerce/variant-options/#{id}", nil, data_transform(data))
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
    # ==== First Example
    #     @data = @mints_user.get_variant_values
    #
    # ==== Second Example
    #     options = { "sort": "-id"}
    #     @data = @mints_user.get_variant_values(options)
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
    # ==== First Example
    #     @data = @mints_user.get_variant_value(5)
    #
    # ==== Second Example
    #     options = { "fields": "id"}
    #     @data = @mints_user.get_variant_value(5, options)
    def get_variant_value(id, options = nil)
      return @client.raw("get", "/ecommerce/variant-values/#{id}", options)
    end

    # === Create variant value.
    # Create a variant value with data.
    #
    # ==== Parameters
    # data:: (Hash) -- Data to be submited.
    #
    # ==== Example
    #     data = {
    #       "value": "New Variant Value",
    #       "variant_option_id": 1,
    #       "display_order": 1,
    #       "sku_code": "new-variant-value-sku"
    #     }
    #     @data = @mints_user.create_variant_value(data)
    def create_variant_value(data)
      return @client.raw("post", "/ecommerce/variant-values", nil, data_transform(data))
    end

    # === Update variant value.
    # Update a variant value info.
    #
    # ==== Parameters
    # id:: (Integer) -- Variant value id.
    # data:: (Hash) -- Data to be submited.
    #
    # ==== Example
    #     data = {
    #       "value": "New Variant Value Modified"
    #     }
    #     @data = @mints_user.update_variant_value(22, data)
    def update_variant_value(id, data)
      return @client.raw("put", "/ecommerce/variant-values/#{id}", nil, data_transform(data))
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
    # ==== Example
    #     @data = @mints_user.get_product_templates_support_data_from_product(1)
    def get_product_templates_support_data_from_product(id)
      return @client.raw("get", "/ecommerce/product-templates/support-data/products/#{id}")
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
    # ==== First Example
    #     @data = @mints_user.get_product_templates
    #
    # ==== Second Example
    #     options = { "fields": "title" }
    #     @data = @mints_user.get_product_templates(options)
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
    # ==== First Example
    #     @data = @mints_user.get_product_template(1)
    #
    # ==== Second Example
    #     options = { "fields": "title" }
    #     @data = @mints_user.get_product_template(1, options)
    def get_product_template(id, options = nil)
      return @client.raw("get", "/ecommerce/product-templates/#{id}", options)
    end
    
    # === Create product template.
    # Create a product template with data.
    #
    # ==== Parameters
    # data:: (Hash) -- Data to be submited.
    #
    # ==== Example
    #     data = { 
    #       "title": "New Product Template",
    #       "slug": "new-product-template"
    #     }
    #     @data = @mints_user.create_product_template(data)
    def create_product_template(data)
      return @client.raw("post", "/ecommerce/product-templates/", nil, data_transform(data))
    end
    
    # === Update product template.
    # Update a product template info.
    #
    # ==== Parameters
    # id:: (Integer) -- Product template id.
    # data:: (Hash) -- Data to be submited.
    #
    # ==== Example
    #     data = {
    #       "title": "New Product Template Modified",
    #       "slug": "new-product-template"
    #     }
    #     @data = @mints_user.update_product_template(3, data)
    def update_product_template(id, data)
      return @client.raw("put", "/ecommerce/product-templates/#{id}", nil, data_transform(data))
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
    # ==== Example
    #     data = {
    #       "ids": [ 18 ]
    #     }
    #     @data = @mints_user.delete_orders(data)
    def delete_orders(data) #TODO: Inform method should return another response like 'success'
      return @client.raw("delete", "/ecommerce/orders/delete", nil, data_transform(data))
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
    # use_post:: (Boolean) -- Variable to determine if the request is by 'post' or 'get' functions.
    #
    # ==== First Example
    #     @data = @mints_user.get_orders
    #
    # ==== Second Example
    #     options = { "fields": "id, title" }
    #     @data = @mints_user.get_orders(options)
    #
    # ==== Third Example
    #     options = { "fields": "id, title" }
    #     @data = @mints_user.get_orders(options, false)
    def get_orders(options = nil, use_post = true)
      return get_query_results("/ecommerce/orders", options, use_post)
    end

    # === Get order.
    # Get a order info.
    #
    # ==== Parameters
    # id:: (Integer) -- Order id.
    # options:: (Hash) -- List of {Resource collection Options}[#class-Mints::User-label-Resource+collections+options+] shown above can be used as parameter.
    #
    # ==== First Example
    #     @data = @mints_user.get_order(1)
    #
    # ==== Second Example
    #     options = { "fields": "title" }
    #     @data = @mints_user.get_order(1, options)
    def get_order(id, options = nil)
      return @client.raw("get", "/ecommerce/orders/#{id}", options)
    end

    # === Create order.
    # Create a order with data.
    #
    # ==== Parameters
    # data:: (Hash) -- Data to be submited.
    #
    # ==== Example
    #     data = {
    #       "title": "New Order",
    #       "order_template_id": 2
    #     }
    #     @data = @mints_user.create_order(data)
    def create_order(data)
      return @client.raw("post", "/ecommerce/orders", nil, data_transform(data))
    end

    # === Update order.
    # Update a order info.
    #
    # ==== Parameters
    # id:: (Integer) -- Order id.
    # data:: (Hash) -- Data to be submited.
    #
    # ==== Example
    #     data = {
    #       "title": "New Order Modified"
    #     }
    #     @data = @mints_user.update_order(26, data)
    def update_order(id, data)
      return @client.raw("put", "/ecommerce/orders/#{id}", nil, data_transform(data))
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
    # ==== Example
    #     @data = @mints_user.get_order_template_support_data(1)
    def get_order_template_support_data(id)
      return @client.raw("get", "/ecommerce/order-templates/support-data/#{id}")
    end

    # === Get order templates.
    # Get a collection of order templates.
    #
    # ==== Parameters
    # options:: (Hash) -- List of {Resource collection Options}[#class-Mints::User-label-Resource+collections+options+] shown above can be used as parameter.
    #
    # ==== First Example
    #     @data = @mints_user.get_order_templates
    #
    # ==== Second Example
    #     options = { "fields": "title" }
    #     @data = @mints_user.get_order_templates(options)
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
    # ==== First Example
    #     @data = @mints_user.get_order_template(1)
    #
    # ==== Second Example
    #     options = { "fields": "title" }
    #     @data = @mints_user.get_order_template(1, options)
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
    # ==== Example
    #     data = {
    #       "title": "Inventory Increase"
    #     }
    #     @data = @mints_user.update_order_template(12, data)
    def update_order_template(id, data)
      return @client.raw("put", "/ecommerce/order-templates/#{id}", nil, data_transform(data))
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
    
    #TODO: The following two methods receive objects instead integer variable. Research use and test it.
    # === Detach order item from order item group.
    # Detach an order item from an order item group.
    #
    # ==== Parameters
    # orderItemId:: (Integer) -- Order item id.
    # groupId:: (Integer) -- Order items group id.
    #
    def detach_order_item_from_order_item_group(orderItemId, groupId) #TODO: Research use
      return @client.raw("put", "/ecommerce/order-items/detach/#{orderItemId}/order-items-groups/#{groupId}")
    end

    # === Update order item from order item group.
    # Update an order item data from an order item group.
    #
    # ==== Parameters
    # orderItemId:: (Integer) -- Order item id.
    # groupId:: (Integer) -- Order items group id.
    #
    def update_order_item_from_order_item_group(orderItemId, groupId, data) #TODO: Research use
      return @client.raw("put", "/ecommerce/order-items/update/#{orderItemId}/order-items-groups/#{groupId}", nil, data_transform(data))
    end
    
    # === Get order items.
    # Get a collection of order items.
    #
    # ==== Parameters
    # options:: (Hash) -- List of {Resource collection Options}[#class-Mints::User-label-Resource+collections+options+] shown above can be used as parameter.
    #
    # ==== First Example
    #     @data = @mints_user.get_order_items
    #
    # ==== Second Example
    #     options = { "fields": "id" }
    #     @data = @mints_user.get_order_items(options)
    def get_order_items(options = nil) #FIXME: CaliRouter POST method not supported.
      return @client.raw("get", "/ecommerce/order-items", options)
    end

    # === Get order item.
    # Get a order item info.
    #
    # ==== Parameters
    # id:: (Integer) -- Order item id.
    # options:: (Hash) -- List of {Resource collection Options}[#class-Mints::User-label-Resource+collections+options+] shown above can be used as parameter.
    #
    # ==== First Example
    #     @data = @mints_user.get_order_item(1)
    #
    # ==== Second Example
    #     options = { "fields": "id" }
    #     @data = @mints_user.get_order_item(1, options)
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
    # ==== Example
    #     data = { "title": "No title in order items" }
    #     @data = @mints_user.update_order_item(1, data)
    def update_order_item(id, data) #TODO: Research what can update
      return @client.raw("put", "/ecommerce/order-items/#{id}", nil, data_transform(data))
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
    # ==== Example
    #     @data = @mints_user.get_pending_order_template_from_order_item_group(1, 1)
    def get_pending_order_template_from_order_item_group(parentOrderId, orderTemplateId)
      return @client.raw("get", "/ecommerce/order-items-groups/#{parentOrderId}/pending-items/order-template/#{orderTemplateId}")
    end
    
    # === Get order item group support data by order id.
    # Get support data of an order item group by an order id.
    #
    # ==== Parameters
    # orderId:: (Integer) -- Order id.
    #
    # ==== Example
    #     @data = @mints_user.get_order_item_group_support_data_by_order_id(1)
    def get_order_item_group_support_data_by_order_id(orderId) #FIXME: Return in OrderItemsGroupController.getTemplateSupportDataByOrderId method doesnt create data variable.
      return @client.raw("get", "/ecommerce/order-items-groups/support-data/#{orderId}")
    end

    # === Get order item groups.
    # Get a collection of order item groups.
    #
    # ==== Parameters
    # options:: (Hash) -- List of {Resource collection Options}[#class-Mints::User-label-Resource+collections+options+] shown above can be used as parameter.
    #
    # ==== First Example
    #     @data = @mints_user.get_order_item_groups
    #
    # ==== Second Example
    #     options = { "fields": "name" }
    #     @data = @mints_user.get_order_item_groups(options)
    def get_order_item_groups(options = nil)
      return @client.raw("get", "/ecommerce/order-items-groups", options)
    end

    # === Get order item group.
    # Get a order item group info.
    #
    # ==== Parameters
    # id:: (Integer) -- Order item group id.
    # options:: (Hash) -- List of {Resource collection Options}[#class-Mints::User-label-Resource+collections+options+] shown above can be used as parameter.
    #
    # ==== First Example
    #     @data = @mints_user.get_order_item_group(1)
    #
    # ==== Second Example
    #     options = { "fields": "name" }
    #     @data = @mints_user.get_order_item_group(1, options)
    def get_order_item_group(id, options = nil)
      return @client.raw("get", "/ecommerce/order-items-groups/#{id}", options)
    end
    
    # === Create order item group.
    # Create a order item group with data.
    #
    # ==== Parameters
    # data:: (Hash) -- Data to be submited.
    #
    # ==== Example
    #     data = {
    #       "name": "New Order Item Group",
    #       "order_id": 1,
    #       "quantity": 1,
    #       "sale_price": 200
    #     }
    #     @data = @mints_user.create_order_item_group(data)
    def create_order_item_group(data)
      return @client.raw("post", "/ecommerce/order-items-groups", nil, data_transform(data))
    end
    
    # === Update order item group.
    # Update a order item group info.
    #
    # ==== Parameters
    # id:: (Integer) -- Order item group id.
    # data:: (Hash) -- Data to be submited.
    #
    # ==== Example
    #     data = {
    #       "name": "New Order Item Group Modified"
    #     }
    #     @data = @mints_user.update_order_item_group(147, data)
    def update_order_item_group(id, data)
      return @client.raw("put", "/ecommerce/order-items-groups/#{id}", nil, data_transform(data))
    end
    
    # === Delete order item group.
    # Delete a order item group.
    #
    # ==== Parameters
    # id:: (Integer) -- Order item group id.
    #
    # ==== Example
    #     @data = @mints_user.delete_order_item_group(147)
    def delete_order_item_group(id)
      return @client.raw("delete", "/ecommerce/order-items-groups/#{id}")
    end

    ##
    # == Order Statuses
    #

    # === Get order statuses.
    # Get order statuses.
    #
    # ==== First Example
    #     @data = @mints_user.get_order_statuses
    def get_order_statuses
      return @client.raw("get", "/ecommerce/order-statuses")
    end
    
    # === Get order status.
    # Get status of an order.
    #
    # ==== Parameters
    # id:: (Integer) -- Order id.
    #
    # ==== First Example
    #     @data = @mints_user.get_order_status(1)
    def get_order_status(id)
      return @client.raw("get", "/ecommerce/order-statuses/#{id}")
    end

    ##
    # == Item Prices
    #

    # === Get item prices.
    # Get a collection of item prices.
    #
    # ==== Parameters
    # options:: (Hash) -- List of {Resource collection Options}[#class-Mints::User-label-Resource+collections+options+] shown above can be used as parameter.
    #
    # ==== First Example
    #     @data = @mints_user.get_item_prices
    #
    # ==== Second Example
    #     options = { "fields": "price_cents" }
    #     @data = @mints_user.get_item_prices(options)
    def get_item_prices(options = nil)
      return @client.raw("get", "/ecommerce/item-prices", options)
    end

    # === Get item price.
    # Get a item price info.
    #
    # ==== Parameters
    # id:: (Integer) -- Item price id.
    # options:: (Hash) -- List of {Resource collection Options}[#class-Mints::User-label-Resource+collections+options+] shown above can be used as parameter.
    #
    # ==== First Example
    #     @data = @mints_user.get_item_price(1)
    #
    # ==== Second Example
    #     options = { "fields": "price_cents" }
    #     @data = @mints_user.get_item_price(1, options)
    def get_item_price(id, options = nil)
      return @client.raw("get", "/ecommerce/item-prices/#{id}", options)
    end

    # === Create item price.
    # Create a item price with data.
    #
    # ==== Parameters
    # data:: (Hash) -- Data to be submited.
    #
    # ==== Example
    #     data = {
    #       "price_list": [
    #         { "id": 1 },
    #         { "id": 2 }
    #       ],
    #       "price_list_id": 1,
    #       "title": "New Item Price"
    #     }
    #     @data = @mints_user.create_item_price(data)
    def create_item_price(data) #FIXME: Api send sku_id as null and DB doesnt allow that.
      return @client.raw("post", "/ecommerce/item-prices", nil, data_transform(data))
    end

    # === Update item price.
    # Update a item price info.
    #
    # ==== Parameters
    # id:: (Integer) -- Order item price id.
    # data:: (Hash) -- Data to be submited.
    #
    # ==== Example
    #     data = {
    #       "price": 12345
    #     }
    #     @data = @mints_user.update_item_price(1, data)
    def update_item_price(id, data)
      return @client.raw("put", "/ecommerce/item-prices/#{id}", nil, data_transform(data))
    end
    
    # === Delete item price.
    # Delete a item price.
    #
    # ==== Parameters
    # id:: (Integer) -- Item price id.
    #
    # ==== Example
    #     @data = @mints_user.delete_item_price(803)
    def delete_item_price(id)
      return @client.raw("delete", "/ecommerce/item-prices/#{id}")
    end

    ##
    # == Sku
    #

    # === Get skus.
    # Get a collection of skus.
    #
    # ==== Parameters
    # options:: (Hash) -- List of {Resource collection Options}[#class-Mints::User-label-Resource+collections+options+] shown above can be used as parameter.
    #
    # ==== First Example
    #     @data = @mints_user.get_skus
    #
    # ==== Second Example
    #     options = {
    #       "fields": "sku"
    #     }
    #     @data = @mints_user.get_skus(options)
    def get_skus(options = nil)
      return @client.raw("get", "/ecommerce/skus", options)
    end
    
    # === Get sku.
    # Get a sku info.
    #
    # ==== Parameters
    # id:: (Integer) -- Sku id.
    # options:: (Hash) -- List of {Resource collection Options}[#class-Mints::User-label-Resource+collections+options+] shown above can be used as parameter.
    #
    # ==== First Example
    #     @data = @mints_user.get_sku(1)
    #
    # ==== Second Example
    #     options = {
    #       "fields": "title, sku"
    #     }
    #     @data = @mints_user.get_sku(1, options)
    def get_sku(id, options = nil)
      return @client.raw("get", "/ecommerce/skus/#{id}", options)
    end

    # === Create sku.
    # Create a sku with data.
    #
    # ==== Parameters
    # data:: (Hash) -- Data to be submited.
    #
    # ==== Example
    #     data = {
    #       "sku": "NEW-SKU-XXXXXX",
    #       "title": "New Sku",
    #       "slug": "new-sku",
    #       "product_id": 1
    #     }
    #     @data = @mints_user.create_sku(data)
    def create_sku(data)
      return @client.raw("post", "/ecommerce/skus", nil, data_transform(data))
    end
    
    # === Update sku.
    # Update a sku info.
    #
    # ==== Parameters
    # id:: (Integer) -- Sku id.
    # data:: (Hash) -- Data to be submited.
    #
    # ==== Example
    #     data = {
    #       "sku": "NEW-SKU-XXXXXY"
    #     }
    #     @data = @mints_user.update_sku(531, data)
    def update_sku(id, data)
      return @client.raw("put", "/ecommerce/skus/#{id}", nil, data_transform(data))
    end
    
    # === Delete sku.
    # Delete a sku.
    #
    # ==== Parameters
    # id:: (Integer) -- Sku id.
    #
    # ==== Example
    #     @data = @mints_user.delete_sku(531)
    def delete_sku(id)
      return @client.raw("delete", "/ecommerce/skus/#{id}")
    end
    
    ##
    # == Taxes
    #

    # === Get taxes.
    # Get a collection of taxes.
    #
    # ==== Parameters
    # options:: (Hash) -- List of {Resource collection Options}[#class-Mints::User-label-Resource+collections+options+] shown above can be used as parameter.
    #
    # ==== First Example
    #     @data = @mints_user.get_taxes
    #
    # ==== Second Example
    #     options = { "fields": "title" }
    #     @data = @mints_user.get_taxes(options)
    def get_taxes(options = nil)
      return @client.raw("get", "/ecommerce/taxes", options)
    end

    # === Get tax.
    # Get a tax info.
    #
    # ==== Parameters
    # id:: (Integer) -- Tax id.
    # options:: (Hash) -- List of {Resource collection Options}[#class-Mints::User-label-Resource+collections+options+] shown above can be used as parameter.
    #
    # ==== First Example
    #     @data = @mints_user.get_tax(1)
    #
    # ==== Second Example
    #     options = { "fields": "title" }
    #     @data = @mints_user.get_tax(1, options)
    def get_tax(id, options = nil)
      return @client.raw("get", "/ecommerce/taxes/#{id}", options)
    end
    
    # === Create tax.
    # Create a tax with data.
    #
    # ==== Parameters
    # data:: (Hash) -- Data to be submited.
    #
    # ==== Example
    #     data = {
    #       "title": "New Tax",
    #       "tax_percentage": 100
    #     }
    #     @data = @mints_user.create_tax(data)
    def create_tax(data)
      return @client.raw("post", "/ecommerce/taxes", nil, data_transform(data))
    end
    
    # === Update tax.
    # Update a tax info.
    #
    # ==== Parameters
    # id:: (Integer) -- Tax id.
    # data:: (Hash) -- Data to be submited.
    #
    # ==== Example
    #     data = {
    #       "tax_percentage": 10
    #     }
    #     @data = @mints_user.update_tax(11, data)
    def update_tax(id, data)
      return @client.raw("put", "/ecommerce/taxes/#{id}", nil, data_transform(data))
    end
    
    # === Delete tax.
    # Delete a tax.
    #
    # ==== Parameters
    # id:: (Integer) -- Tax id.
    #
    # ==== Example
    #     @data = @mints_user.delete_tax(11)
    def delete_tax(id)
      return @client.raw("delete", "/ecommerce/taxes/#{id}")
    end


    ######################################### Config #########################################


    ##
    # == Importers
    #

    # === Get importers results.
    # Get a results of importers.
    #
    # ==== Parameters
    # options:: (Hash) -- List of {Resource collection Options}[#class-Mints::User-label-Resource+collections+options+] shown above can be used as parameter.
    #
    # ==== Example
    #     options = { "ip_id": 1 }
    #     @data = @mints_user.get_importers_results(options)
    def get_importers_results(options) #FIXME: Query doesnt get results. Maybe no data in db.
      return @client.raw("get", "/config/importers/results", options)
    end
    
    # === Get importers configuration.
    # Get configurations of importers.
    #
    # ==== Example
    #     @data = @mints_user.get_importers_configuration
    def get_importers_configuration
      return @client.raw("get", "/config/importers/configuration")
    end

    # === Get importing process status.
    # Get importing process status by importer ids.
    #
    # ==== Parameters
    # options:: (Hash) -- List of {Resource collection Options}[#class-Mints::User-label-Resource+collections+options+] shown above can be used as parameter.
    #
    # ==== Example
    #     options = {
    #       "ids": "1,2,3"
    #     }
    #     @data = @mints_user.get_importing_process_status(options)
    def get_importing_process_status(options = nil)
      return @client.raw("get", "/config/importers/importing_process_status", options)
    end

    # === Get importers attributes.
    # Get import attributes of modules in a table.
    #
    # ==== Parameters
    # options:: (Hash) -- List of {Resource collection Options}[#class-Mints::User-label-Resource+collections+options+] shown above can be used as parameter.
    #
    # ==== Example
    #     options = {
    #       "table": "contacts",
    #       "module": "crm"
    #     }
    #     @data = @mints_user.get_importers_attributes(options)
    def get_importers_attributes(options = nil)
      return @client.raw("get", "/config/importers/attributes", options)
    end

    # === Upload importer.
    # Upload to an importer.
    #
    # ==== Parameters
    # id:: (Integer) -- Importer id.
    # data:: (Hash) -- Data to be submited.
    #
    # ==== Example
    #     data = {
    #       "csv": "archive.csv"
    #     }
    #     @data = @mints_user.upload_importer(1, data.to_json)
    def upload_importer(id, data) #TODO: Search for csv archives
      return @client.raw("post", "/config/importers/#{id}/upload", nil, data)
    end

    # === Import row.
    # Import a row.
    #
    # ==== Parameters
    # data:: (Hash) -- Data to be submited.
    #
    # ==== Example
    #     
    def import_row(data) #TODO: Research use
      return @client.raw("post", "/config/importers/import_row", nil, data)
    end
    
    # === Remove importers active process.
    # Remove an active process in an importer.
    #
    # ==== Parameters
    # data:: (Hash) -- Data to be submited.
    #
    # ==== Example
    #     
    def remove_importers_active_process(data) #FIXME: Cannot get property 'active_importing_process' of non-object. 
      return @client.raw("post", "/config/importers/removeActiveProcess", nil, data_transform(data))
    end
    
    # === Get importers.
    # Get a collection of importers.
    #
    # ==== Parameters
    # options:: (Hash) -- List of {Resource collection Options}[#class-Mints::User-label-Resource+collections+options+] shown above can be used as parameter.
    #
    # ==== First Example
    #     @data = @mints_user.get_importers
    #
    # ==== Second Example
    #     options = { "fields": "name" }
    #     @data = @mints_user.get_importers(options)
    def get_importers(options = nil)
      return @client.raw("get", "/config/importers", options)
    end

    # === Get importer.
    # Get an importer info.
    #
    # ==== Parameters
    # id:: (Integer) -- Importer id.
    # options:: (Hash) -- List of {Resource collection Options}[#class-Mints::User-label-Resource+collections+options+] shown above can be used as parameter.
    #
    # ==== First Example
    #     @data = @mints_user.get_importer(1)
    #
    # ==== Second Example
    #     options = { "fields": "name" }
    #     @data = @mints_user.get_importer(1, options)
    def get_importer(id, options = nil)
      return @client.raw("get", "/config/importers/#{id}", options)
    end

    # === Create importer.
    # Create an importer with data.
    #
    # ==== Parameters
    # data:: (Hash) -- Data to be submited.
    #
    # ==== Example
    #     data = {
    #       "name": "New Importer",
    #       "module": "crm"
    #     }
    #     @data = @mints_user.create_importer(data)
    def create_importer(data)
      return @client.raw("post", "/config/importers", nil, data_transform(data))
    end

    # === Update importer.
    # Update an importer info.
    #
    # ==== Parameters
    # id:: (Integer) -- Importer id.
    # data:: (Hash) -- Data to be submited.
    #
    # ==== Example
    #     data = {
    #       "name": "New Importer Modified"
    #     }
    #     @data = @mints_user.update_importer(4, data)
    def update_importer(id, data)
      return @client.raw("put", "/config/importers/#{id}", nil, data_transform(data))
    end

    # === Delete importer.
    # Delete a importer.
    #
    # ==== Parameters
    # id:: (Integer) -- Importer id.
    #
    # ==== Example
    #     @data = @mints_user.delete_importer(4)
    def delete_importer(id)
      return @client.raw("delete", "/config/importers/#{id}")
    end
    
    # === Get importers pusher key.
    # Get the pusher key of importers.
    #
    # ==== Example
    #     @data = @mints_user.get_importers_pusher_key
    def get_importers_pusher_key
      return @client.raw("get", "/config/pusher_key")
    end

    ##
    # == Attributes
    #

    # === Get attributes data types.
    # Get data types used in attributes.
    #
    # ==== Example
    #     @data = @mints_user.get_attributes_data_types
    def get_attributes_data_types
      return @client.raw("get", "/config/attributes/data-types")
    end
    
    # === Get attributes.
    # Get a collection of attributes.
    #
    # ==== Example
    #     @data = @mints_user.get_attributes
    def get_attributes
      return @client.raw("get", "/config/attributes")
    end
    
    # === Get attribute.
    # Get an attribute info.
    #
    # ==== Parameters
    # id:: (Integer) -- Attribute id.
    #
    # ==== Example
    #     @data = @mints_user.get_attribute(1)
    def get_attribute(id)
      return @client.raw("get", "/config/attributes/#{id}")
    end

    # === Create attribute.
    # Create an attribute with data.
    #
    # ==== Parameters
    # data:: (Hash) -- Data to be submited.
    #
    # ==== Example
    #     data = {
    #       "title": "New Attribute",
    #       "object_type": "orders",
    #       "slug": "new_attribute",
    #       "attribute_group_id": 1,
    #       "data_type_enum": 10
    #     }
    #     @data = @mints_user.create_attribute(data)
    def create_attribute(data)
      return @client.raw("post", "/config/attributes", nil, data_transform(data))
    end

    # === Update attribute.
    # Update an attribute info.
    #
    # ==== Parameters
    # id:: (Integer) -- Attribute id.
    # data:: (Hash) -- Data to be submited.
    #
    # ==== Example
    #     data = {
    #       "title": "New Attribute Modified",
    #       "object_type": "orders",
    #       "slug": "new_attribute",
    #       "attribute_group_id": 1,
    #       "data_type_enum": 10
    #     }
    #     @data = @mints_user.update_attribute(292, data)
    def update_attribute(id, data)
      return @client.raw("put", "/config/attributes/#{id}", nil, data_transform(data))
    end

    ##
    # == Attribute Groups
    #

    # === Get attribute groups data types.
    # Get data types used in attribute groups.
    #
    # ==== Example
    #     @data = @mints_user.get_attribute_groups_data_types
    def get_attribute_groups_data_types
      return @client.raw("get", "/config/attribute-groups/object-types")
    end

    # === Get attribute groups.
    # Get a collection of attribute groups.
    #
    # ==== Parameters
    # options:: (Hash) -- List of {Resource collection Options}[#class-Mints::User-label-Resource+collections+options+] shown above can be used as parameter.
    #
    # ==== First Example
    #     @data = @mints_user.get_attribute_groups
    #
    # ==== Second Example
    #     options = { "sort": "id" }
    #     @data = @mints_user.get_attribute_groups(options)
    def get_attribute_groups(options = nil)
      return @client.raw("get", "/config/attribute-groups", options)
    end
    
    # === Get attribute group.
    # Get an attribute group info.
    #
    # ==== Parameters
    # id:: (Integer) -- Attribute group id.
    #
    # ==== Example
    #     @data = @mints_user.get_attribute_group(10)
    def get_attribute_group(id)
      return @client.raw("get", "/config/attribute-groups/#{id}")
    end

    # === Create attribute group.
    # Create an attribute group with data.
    #
    # ==== Parameters
    # data:: (Hash) -- Data to be submited.
    #
    # ==== Example
    #     data = {
    #       "title": "New Attribute Group",
    #       "object_type": "contacts"
    #     }
    #     @data = @mints_user.create_attribute_group(data)
    def create_attribute_group(data)
      return @client.raw("post", "/config/attribute-groups", nil, data_transform(data))
    end

    # === Update attribute group.
    # Update an attribute group info.
    #
    # ==== Parameters
    # id:: (Integer) -- Attribute group id.
    # data:: (Hash) -- Data to be submited.
    #
    # ==== Example
    #     data = {
    #       "title": "New Attribute Group Modified",
    #       "object_type": "contacts",
    #       "slug": "new-attribute-group",
    #       "description": "New description"
    #     }
    #     @data = @mints_user.update_attribute_group(36, data)
    def update_attribute_group(id, data)
      return @client.raw("put", "/config/attribute-groups/#{id}", nil, data_transform(data))
    end

    ##
    # == Categories
    #

    #def sync_categories_for_object(data)
    #  return @client.raw("put", "/config/categories/sync_categories_for_object", nil, data)
    #end

    #def get_categories_for_object(options)
    #  return @client.raw("get", "/config/categories/get_categories_for_object", options)
    #end
    
    #def get_categories
    #  return @client.raw("get", "/config/categories")
    #end

    #def create_category(data) #TODO: Research if 'visible' is a boolean or int. It accepts smallint
    #  return @client.raw("post", "/config/categories", nil, data)
    #end

    #def update_category(id, data)
    #  return @client.raw("put", "/config/categories/#{id}", nil, data)
    #end

    #def get_category_support_data(id)
    #  return @client.raw("get", "/config/categories/support-data/#{id}")
    #end
    
    #def get_category(id)
    #  return @client.raw("get", "/config/categories/#{id}")
    #end

    ##
    # == Public Folders
    #

    # === Sync public folders for object.
    # Sync public folders for object.
    #
    # ==== Parameters
    # data:: (Hash) -- Data to be submited.
    #
    # ==== Example
    #     data = {
    #       "object_type": "contacts",
    #       "object_id": 1
    #     }
    #     @data = @mints_user.sync_public_folders_for_object(data.to_json)
    def sync_public_folders_for_object(data)
      return @client.raw("put", "/config/public-folders/sync_public-folders_for_object", nil, data)
    end
    
    # === Get public folders for object.
    # Get public folders for object.
    #
    # ==== Parameters
    # options:: (Hash) -- List of {Resource collection Options}[#class-Mints::User-label-Resource+collections+options+] shown above can be used as parameter.
    #
    # ==== Example
    #     options = {
    #       "object_type": "contacts",
    #       "object_id": 1
    #     }
    #     @data = @mints_user.get_public_folders_for_object(options)
    def get_public_folders_for_object(options)
      return @client.raw("get", "/config/public-folders/get_public-folders_for_object", options)
    end

    # === Get public folders.
    # Get a collection of public folders.
    #
    # ==== Example
    #     @data = @mints_user.get_public_folders
    def get_public_folders
      return @client.raw("get", "/config/public-folders")
    end
    
    # === Create public folder.
    # Create a public folder with data.
    #
    # ==== Parameters
    # data:: (Hash) -- Data to be submited.
    #
    # ==== Example
    #     data = {
    #       "title": "New Public Folder",
    #       "slug": "new-public-folder",
    #       "object_type": "contacts",
    #       "visible": true
    #     }
    #     @data = @mints_user.create_public_folder(data.to_json)
    def create_public_folder(data)
      return @client.raw("post", "/config/public-folders", nil, data)
    end

    # === Update public folder.
    # Update a public folder info.
    #
    # ==== Parameters
    # id:: (Integer) -- Public folder id.
    # data:: (Hash) -- Data to be submited.
    #
    # ==== Example
    #     data = {
    #       "title": "New Public Folder Modified",
    #       "slug": "new-public-folder",
    #       "object_type": "contacts",
    #       "visible": true
    #     }
    #     @data = @mints_user.update_public_folder(20, data.to_json)
    def update_public_folder(id, data)
      return @client.raw("put", "/config/public-folders/#{id}", nil, data)
    end
    
    # === Get public folder support data.
    # Get support data used in a public folder.
    #
    # ==== Parameters
    # id:: (Integer) -- Public folder id.
    #
    # ==== Example
    #     @data = @mints_user.get_public_folder_support_data(1)
    def get_public_folder_support_data(id)
      return @client.raw("get", "/config/public-folders/support-data/#{id}")
    end
    
    # === Get public folder.
    # Get a public folder info.
    #
    # ==== Parameters
    # id:: (Integer) -- Public folder id.
    # options:: (Hash) -- List of {Resource collection Options}[#class-Mints::User-label-Resource+collections+options+] shown above can be used as parameter.
    #
    # ==== Example
    #      @data = @mints_user.get_public_folder(3)
    def get_public_folder(id)
      return @client.raw("get", "/config/public-folders/#{id}")
    end
    

    ##
    # == Taxonomies
    #

    # === Sync taxonomies for object.
    # Sync taxonomies for object.
    #
    # ==== Parameters
    # data:: (Hash) -- Data to be submited.
    #
    # ==== Example
    #     data = {
    #       "object_type": "contacts",
    #       "object_id": 1
    #     }
    #     @data = @mints_user.sync_taxonomies_for_object(data)
    def sync_taxonomies_for_object(data)
      return @client.raw("put", "/config/taxonomies/sync_taxonomies_for_object", nil, data_transform(data))
    end

    # === Get taxonomies for object.
    # Get taxonomies for object.
    #
    # ==== Parameters
    # options:: (Hash) -- List of {Resource collection Options}[#class-Mints::User-label-Resource+collections+options+] shown above can be used as parameter.
    #
    # ==== Example
    #     options = {
    #       "object_type": "contacts",
    #       "object_id": 1
    #     }
    #     @data = @mints_user.get_taxonomies_for_object(options)
    def get_taxonomies_for_object(options)
      return @client.raw("get", "/config/taxonomies/get_taxonomies_for_object", options)
    end
    
    # === Get taxonomies support data.
    # Get support data used in taxonomies.
    #
    # ==== Example
    #     @data = @mints_user.get_taxonomies_support_data
    def get_taxonomies_support_data
      return @client.raw("get", "/config/taxonomies/support-data")
    end
    
    #FIXME: Method doesnt exist in TaxonomyController.getUISupportData
    #def get_ui_taxonomy(id)
    #  return @client.raw("get", "/config/taxonomies/ui-taxonomies/#{id}")
    #end
    
    # === Get taxonomies.
    # Get a collection of taxonomies.
    #
    # ==== Parameters
    # options:: (Hash) -- List of {Resource collection Options}[#class-Mints::User-label-Resource+collections+options+] shown above can be used as parameter.
    # use_post:: (Boolean) -- Variable to determine if the request is by 'post' or 'get' functions.
    #
    # ==== First Example
    #     @data = @mints_user.get_taxonomies
    #
    # ==== Second Example
    #     options = { "fields": "title" }
    #     @data = @mints_user.get_taxonomies(options)
    #
    # ==== Third Example
    #     options = { "fields": "title" }
    #     @data = @mints_user.get_taxonomies(options, false)
    def get_taxonomies(options = nil, use_post = true)
      return get_query_results("/config/taxonomies", options, use_post)
    end

    # === Get taxonomy.
    # Get a taxonomy info.
    #
    # ==== Parameters
    # id:: (Integer) -- Taxonomy id.
    # options:: (Hash) -- List of {Resource collection Options}[#class-Mints::User-label-Resource+collections+options+] shown above can be used as parameter.
    #
    # ==== First Example
    #     @data = @mints_user.get_taxonomy(1)
    #
    # ==== Second Example
    #     options = { "fields": "title" }
    #     @data = @mints_user.get_taxonomy(1, options)
    def get_taxonomy(id, options = nil)
      return @client.raw("get", "/config/taxonomies/#{id}", options)
    end

    # === Create taxonomy.
    # Create a taxonomy with data.
    #
    # ==== Parameters
    # data:: (Hash) -- Data to be submited.
    #
    # ==== Example
    #     data = {
    #       "title": "New Taxonomy",
    #       "slug": "new-taxonomy",
    #       "object_type": "contacts"
    #     }
    #     @data = @mints_user.create_taxonomy(data)
    def create_taxonomy(data)
      return @client.raw("post", "/config/taxonomies", nil, data_transform(data))
    end
    
    # === Update taxonomy.
    # Update a taxonomy info.
    #
    # ==== Parameters
    # id:: (Integer) -- Taxonomy id.
    # data:: (Hash) -- Data to be submited.
    #
    # ==== Example
    #     data = {
    #       "title": "New Taxomony Modified",
    #       "slug": "new-taxonomy",
    #       "object_type": "contacts"
    #     }
    #     @data = @mints_user.update_taxonomy(104, data)
    def update_taxonomy(id, data)
      return @client.raw("put", "/config/taxonomies/#{id}", nil, data_transform(data))
    end
    
    ##
    # == Relationships
    #
    
    # === Get relationships available for.
    # Get relationships availables.
    #
    # ==== Parameters
    # options:: (Hash) -- List of {Resource collection Options}[#class-Mints::User-label-Resource+collections+options+] shown above can be used as parameter.
    #
    # ==== Example
    #     options = {
    #       "objectType": "contacts"
    #     }
    #     @data = @mints_user.get_relationships_available_for(options)
    def get_relationships_available_for(options)
      return @client.raw("get", "/config/relationships/available-for", options)
    end
    
    # === Attach relationship.
    # Attach a relationship.
    #
    # ==== Parameters
    # data:: (Hash) -- Data to be submited.
    #
    # ==== Example
    #     
    def attach_relationship(data) #FIXME: Method doesn't work, RelationshipManager cannot access to id attribute.
      return @client.raw("post", "/config/relationships/attach", nil, data)
    end

    # === Detach relationship.
    # Detach a relationship.
    #
    # ==== Parameters
    # data:: (Hash) -- Data to be submited.
    #
    # ==== Example
    #     
    def detach_relationship(data) #FIXME: Method doesn't work, RelationshipManager cannot access to id attribute.
      return @client.raw("post", "/config/relationships/detach", nil, data)
    end
    
    # === Relationship has objects.
    # Get relationships that has objects.
    #
    # ==== Parameters
    # id:: (Integer) -- Relationship id.
    #
    # ==== Example
    #     @data = @mints_user.relationship_has_objects(1)
    def relationship_has_objects(id)
      return @client.raw("get", "/config/relationships/#{id}/hasObjects")
    end
    
    # === Get relationships.
    # Get a collection of relationships.
    #
    # ==== Parameters
    # options:: (Hash) -- List of {Resource collection Options}[#class-Mints::User-label-Resource+collections+options+] shown above can be used as parameter.
    #
    # ==== First Example
    #     @data = @mints_user.get_relationships
    #
    # ==== Second Example
    #     options = { "fields": "id" }
    #     @data = @mints_user.get_relationships(options)
    def get_relationships(options = nil)
      return @client.raw("get", "/config/relationships", options)
    end

    # === Get relationship.
    # Get a relationship info.
    #
    # ==== Parameters
    # id:: (Integer) -- Relationship id.
    # options:: (Hash) -- List of {Resource collection Options}[#class-Mints::User-label-Resource+collections+options+] shown above can be used as parameter.
    #
    # ==== First Example
    #     @data = @mints_user.get_relationship(1)
    #
    # ==== Second Example
    #     options = { "fields": "id" }
    #     @data = @mints_user.get_relationship(1, options)
    def get_relationship(id, options = nil)
      return @client.raw("get", "/config/relationships/#{id}", options)
    end

    # === Create relationship.
    # Create a relationship with data.
    #
    # ==== Parameters
    # data:: (Hash) -- Data to be submited.
    #
    # ==== Example
    #     data = {
    #       "alias_1": "eventsCopy",
    #       "alias_2": "ticketsCopy",
    #       "object_model_1": "Story",
    #       "object_model_2": "Product"
    #     }
    #     @data = @mints_user.create_relationship(data)
    def create_relationship(data)
      return @client.raw("post", "/config/relationships", nil, data_transform(data))
    end

    # === Update relationship.
    # Update a relationship info.
    #
    # ==== Parameters
    # id:: (Integer) -- Relationship id.
    # data:: (Hash) -- Data to be submited.
    #
    # ==== Example
    #     data = {
    #       "alias_1": "eventsCopyModified",
    #       "alias_2": "ticketsCopyModified",
    #       "object_model_1": "Story",
    #       "object_model_2": "Product"
    #     }
    #     @data = @mints_user.update_relationship(5, data)
    def update_relationship(id, data)
      return @client.raw("put", "/config/relationships/#{id}", nil, data_transform(data))
    end

    # === Delete relationship.
    # Delete a relationship.
    #
    # ==== Parameters
    # id:: (Integer) -- Relationship id.
    #
    # ==== Example
    #     @data = @mints_user.delete_relationship(5)
    def delete_relationship(id)
      return @client.raw("delete", "/config/relationships/#{id}")
    end

    ##
    # == Tags
    #

    # === Get tags.
    # Get a collection of tags.
    #
    # ==== Example
    #     @data = @mints_user.get_tags
    def get_tags
      return @client.raw("get", "/config/tags")
    end

    # === Get tag.
    # Get a tag info.
    #
    # ==== Parameters
    # id:: (Integer) -- Tag id.
    #
    # ==== Example
    #     @data = @mints_user.get_tag(1)
    def get_tag(id)
      return @client.raw("get", "/config/tags/#{id}")
    end

    # === Create tag.
    # Create a tag with data.
    #
    # ==== Parameters
    # data:: (Hash) -- Data to be submited.
    #
    # ==== Example
    #     data = {
    #       "tag": "new-tag",
    #       "is_visible": true
    #     }
    #     @data = @mints_user.create_tag(data.to_json)
    def create_tag(data)
      return @client.raw("post", "/config/tags", nil, data)
    end

    # === Update tag.
    # Update a tag info.
    #
    # ==== Parameters
    # id:: (Integer) -- Tag id.
    # data:: (Hash) -- Data to be submited.
    #
    # ==== Example
    #     data = {
    #       "tag": {
    #         "tag": "new-tag",
    #         "slug": "new-tag",
    #         "is_visible": false
    #       }
    #     }
    #     @data = @mints_user.update_tag(54, data.to_json)
    def update_tag(id, data)
      #TODO: Inform TagController.update method has been modified
      return @client.raw("put", "/config/tags/#{id}", nil, data)
    end

    ##
    # == Roles
    #

    #def get_roles_permissions #FIXME: RoleController doesnt have getPermissions method
    #  return @client.raw("get", "/config/roles/get-permissions")
    #end

    # === Duplicate role.
    # Duplicate a role.
    #
    # ==== Parameters
    # id:: (Integer) -- Role id.
    # data:: (Hash) -- Data to be submited.
    #
    # ==== Example
    #     data = { 
    #       "options": [] 
    #     }
    #     @data = @mints_user.duplicate_role(1, data.to_json)
    def duplicate_role(id, data)
      return @client.raw("post", "/config/roles/#{id}/duplicate", nil, data)
    end
    
    # === Get roles.
    # Get a collection of roles.
    #
    # ==== Example
    #     @data = @mints_user.get_roles
    def get_roles
      return @client.raw("get", "/config/roles")
    end

    # === Get role.
    # Get a role info.
    #
    # ==== Parameters
    # id:: (Integer) -- Role id.
    # options:: (Hash) -- List of {Resource collection Options}[#class-Mints::User-label-Resource+collections+options+] shown above can be used as parameter.
    #
    # ==== Example
    #     @data = @mints_user.get_role(1)
    def get_role(id)
      return @client.raw("get", "/config/roles/#{id}")
    end

    # === Create role.
    # Create a role with data.
    #
    # ==== Parameters
    # data:: (Hash) -- Data to be submited.
    #
    # ==== Example
    #     data = {
    #       "name": "new-role",
    #       "display_name": "New Role",
    #       "description": "Role description"
    #     }
    #     @data = @mints_user.create_role(data)
    def create_role(data)
      return @client.raw("post", "/config/roles", nil, data_transform(data))
    end
    
    # === Update role.
    # Update a role info.
    #
    # ==== Parameters
    # id:: (Integer) -- Role id.
    # data:: (Hash) -- Data to be submited.
    #
    # ==== Example
    #     data = {
    #       "name": "new-role",
    #       "display_name": "New Role Display Name Modified",
    #       "description": "Role description",
    #       "permissions": 1
    #     }
    #     @data = @mints_user.update_role(8, data)
    def update_role(id, data) #FIXME: This action is unauthorized
      #TODO: Research permissions variable type. This would be the error's solution.
      return @client.raw("put", "/config/roles/#{id}", nil, data_transform(data))
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

    # === Get users.
    # Get a collection of users.
    #
    # ==== Example
    #     @data = @mints_user.get_users
    def get_users
      return @client.raw("get", "/config/users")
    end

    # === Get user.
    # Get an user info.
    #
    # ==== Parameters
    # id:: (Integer) -- User id.
    #
    # ==== Example
    #     @data = @mints_user.get_user(8)
    def get_user(id)
      return @client.raw("get", "/config/users/#{id}")
    end
    
    # === Create user.
    # Create an user with data.
    #
    # ==== Parameters
    # data:: (Hash) -- Data to be submited.
    #
    # ==== Example
    #     data = {
    #       "name": "New User Name",
    #       "email": "new_user_email@example.com",
    #       "is_confirmed": false,
    #       "set_password": true, 
    #       "password": "123456",
    #       "is_coach": false
    #     }
    #     @data = @mints_user.create_user(data)
    def create_user(data)
      return @client.raw("post", "/config/users", nil, data_transform(data))
    end

    # === Update user.
    # Update an user info.
    #
    # ==== Parameters
    # id:: (Integer) -- User id.
    # data:: (Hash) -- Data to be submited.
    #
    # ==== Example
    #     data = {
    #       "name": "New User Name Modified",
    #       "email": "new_user_name@example.com",
    #       "is_active": true,
    #       "is_confirmed": false,
    #       "roles": ""
    #     }
    #     @data = @mints_user.update_user(14, data)
    def update_user(id, data)
      return @client.raw("put", "/config/users/#{id}", nil, data_transform(data))
    end

    ##
    # == Teams
    #
    
    # === Get team types.
    # Get a collection of team types.
    #
    # ==== Example
    #     @data = @mints_user.get_team_types
    def get_team_types
      return @client.raw("get", "/config/teams/team-types")
    end
    
    # === Get teams.
    # Get a collection of teams.
    #
    # ==== Example
    #     @data = @mints_user.get_teams
    def get_teams
      return @client.raw("get", "/config/teams")
    end
    
    # === Get team.
    # Get a team info.
    #
    # ==== Parameters
    # id:: (Integer) -- Team id.
    # options:: (Hash) -- List of {Resource collection Options}[#class-Mints::User-label-Resource+collections+options+] shown above can be used as parameter.
    #
    # ==== Example
    #     @data = @mints_user.get_team(1)
    def get_team(id)
      return @client.raw("get", "/config/teams/#{id}")
    end

    # === Create team.
    # Create a team with data.
    #
    # ==== Parameters
    # data:: (Hash) -- Data to be submited.
    #
    # ==== Example
    #     data = {
    #       "title": "New Team",
    #       "team_type_enum": 1
    #     }
    #     @data = @mints_user.create_team(data)
    def create_team(data)
      return @client.raw("post", "/config/teams", nil, data_transform(data))
    end
    
    # === Update team.
    # Update a team info.
    #
    # ==== Parameters
    # id:: (Integer) -- Team id.
    # data:: (Hash) -- Data to be submited.
    #
    # ==== Example
    #     data = {
    #       "title": "New Team Modified",
    #       "team_type_enum": 1,
    #       "members": []
    #     }
    #     @data = @mints_user.update_team(5, data)
    def update_team(id, data)
      return @client.raw("put", "/config/teams/#{id}", nil, data_transform(data))
    end

    ##
    # == Api keys
    #
    
    # === Get api keys.
    # Get a collection of api keys.
    #
    # ==== Parameters
    # options:: (Hash) -- List of {Resource collection Options}[#class-Mints::User-label-Resource+collections+options+] shown above can be used as parameter.
    #
    # ==== First Example
    #     @data = @mints_user.get_api_keys
    #
    # ==== Second Example
    #     options = { "fields": "id" }
    #     @data = @mints_user.get_api_keys(options)
    def get_api_keys(options = nil)
      return @client.raw("get", "/config/api-keys", options)
    end

    # === Get api key.
    # Get an api key info.
    #
    # ==== Parameters
    # id:: (Integer) -- Api key id.
    # options:: (Hash) -- List of {Resource collection Options}[#class-Mints::User-label-Resource+collections+options+] shown above can be used as parameter.
    #
    # ==== First Example
    #     @data = @mints_user.get_api_key(2)
    #
    # ==== Second Example
    #     options = { "fields": "id" }
    #     @data = @mints_user.get_api_key(2, options)
    def get_api_key(id, options = nil)
      return @client.raw("get", "/config/api-keys/#{id}", options)
    end

    # === Create api key.
    # Create an api key with data.
    #
    # ==== Parameters
    # data:: (Hash) -- Data to be submited.
    #
    # ==== Example
    #     data = {
    #       "description": "New Api Key Description"
    #     }
    #     @data = @mints_user.create_api_key(data)
    def create_api_key(data)
      return @client.raw("post", "/config/api-keys", nil, data_transform(data))
    end

    # === Delete api key.
    # Delete an api key.
    #
    # ==== Parameters
    # id:: (Integer) -- Api key id.
    #
    # ==== Example
    #     @data = @mints_user.delete_api_key(2)
    def delete_api_key(id)
      return @client.raw("delete", "/config/api-keys/#{id}")
    end

    ##
    # == System Settings
    #

    # === Get settings by keys.
    # Get a collection of settings using keys.
    #
    # ==== Example
    #     options = {
    #       "setting_keys": "email_transport_provider,email_template_provider,email_template_default_from_address"
    #     }
    #     @data = @mints_user.get_settings_by_keys(options)
    def get_settings_by_keys(options)
      return @client.raw("get", "/config/settings/by-keys", options)
    end
    
    # === Get settings.
    # Get a collection of settings.
    #
    # ====  Example
    #     @data = @mints_user.get_settings
    def get_settings
      return @client.raw("get", "/config/settings")
    end      

    # === Create setting.
    # Create a setting title with data.
    #
    # ==== Parameters
    # data:: (Hash) -- Data to be submited.
    #
    # ==== Example
    #     data = {
    #       "title": "new_settings"
    #     }
    #     @data = @mints_user.create_setting(data)
    def create_setting(data)
      return @client.raw("post", "/config/settings", nil, data_transform(data))
    end

    ##
    # == Seeds
    #

    # === Apply seeds.
    # Apply seeds.
    #
    # ==== Example
    #
    def apply_seeds(data) #TODO: Research use
      return @client.raw("post", "/config/seeds", nil, data)
    end

    ##
    # == Calendars
    #

    # === Get calendars.
    # Get a collection of calendars.
    #
    # ==== Parameters
    # options:: (Hash) -- List of {Resource collection Options}[#class-Mints::User-label-Resource+collections+options+] shown above can be used as parameter.
    #
    # ==== First Example
    #     @data = @mints_user.get_calendars
    #
    # ==== Second Example
    #     options = {
    #       "fields": "title"
    #     }
    #     @data = @mints_user.get_calendars(options)
    def get_calendars(options = nil)
      return @client.raw("get", "/config/calendars", options)
    end
    
    # === Get calendar.
    # Get a calendar info.
    #
    # ==== Parameters
    # id:: (Integer) -- Calendar id.
    # options:: (Hash) -- List of {Resource collection Options}[#class-Mints::User-label-Resource+collections+options+] shown above can be used as parameter.
    #
    # ==== First Example
    #     @data = @mints_user.get_calendar(1)
    #
    # ==== Second Example
    #     options = {
    #       "fields": "title"
    #     }
    #     @data = @mints_user.get_calendar(1, options)
    def get_calendar(id, options = nil)
      return @client.raw("get", "/config/calendars/#{id}", options)
    end
    
    # === Create calendar.
    # Create a calendar with data.
    #
    # ==== Parameters
    # data:: (Hash) -- Data to be submited.
    #
    # ==== Example
    #     data = { 
    #       "title": "New Calendar",
    #       "object_type": "contacts",
    #       "object_id": 1
    #     }
    #     @data = @mints_user.create_calendar(data)
    def create_calendar(data)
      return @client.raw("post", "/config/calendars", nil, data_transform(data))
    end

    # === Update calendar.
    # Update a calendar info.
    #
    # ==== Parameters
    # id:: (Integer) -- Calendar id.
    # data:: (Hash) -- Data to be submited.
    #
    # ==== Example
    #     data = { 
    #       "title": "New Calendar Modified",
    #       "object_type": "contacts",
    #       "object_id": 1
    #     }
    #     @data = @mints_user.update_calendar(4, data)
    def update_calendar(id, data)
      return @client.raw("put", "/config/calendars/#{id}", nil, data_transform(data))
    end
    
    # === Delete calendar.
    # Delete a calendar.
    #
    # ==== Parameters
    # id:: (Integer) -- Calendar id.
    #
    # ==== Example
    #     @data = @mints_user.delete_calendar(4)
    def delete_calendar(id)
      return @client.raw("delete", "/config/calendars/#{id}")
    end

    ##
    # == Appointments
    #

    # === Get appointments.
    # Get a collection of appointments.
    #
    # ==== Parameters
    # options:: (Hash) -- List of {Resource collection Options}[#class-Mints::User-label-Resource+collections+options+] shown above can be used as parameter.
    #
    # ==== First Example
    #     @data = @mints_user.get_appointments
    #
    # ==== Second Example
    #     options = {
    #       "fields": "id"
    #     }
    #     @data = @mints_user.get_appointments(options)
    def get_appointments(options = nil)
      return @client.raw("get", "/config/appointments", options)
    end
    
    # === Get appointment.
    # Get an appointment info.
    #
    # ==== Parameters
    # id:: (Integer) -- Appointment id.
    # options:: (Hash) -- List of {Resource collection Options}[#class-Mints::User-label-Resource+collections+options+] shown above can be used as parameter.
    #
    # ==== First Example
    #     @data = @mints_user.get_appointment(1)
    #
    # ==== Second Example
    #     options = {
    #       "fields": "id"
    #     }
    #     @data = @mints_user.get_appointment(1, options)
    def get_appointment(id, options = nil)
      return @client.raw("get", "/config/appointments/#{id}", options)
    end
    
    # === Create appointment.
    # Create an appointment with data.
    #
    # ==== Parameters
    # data:: (Hash) -- Data to be submited.
    #
    # ==== Example
    #     data = {
    #       "object_type": "contacts",
    #       "object_id": 1,
    #       "title": "New Appointment",
    #       "start": "2021-09-06T20:29:16+00:00",
    #       "end": "2022-09-06T20:29:16+00:00",
    #       "attendee_id": 1
    #     }
    #     @data = @mints_user.create_appointment(data)
    def create_appointment(data)
      return @client.raw("post", "/config/appointments", nil, data_transform(data))
    end

    # === Update appointment.
    # Update an appointment info.
    #
    # ==== Parameters
    # id:: (Integer) -- Appointment id.
    # data:: (Hash) -- Data to be submited.
    #
    # ==== Example
    #     data = {
    #       "object_id": 2
    #     }
    #     @data = @mints_user.update_appointment(1, data)
    def update_appointment(id, data)
      return @client.raw("put", "/config/appointments/#{id}", nil, data_transform(data))
    end
    
    # === Delete appointment.
    # Delete an appointment.
    #
    # ==== Parameters
    # id:: (Integer) -- Appointment id.
    #
    # ==== Example
    #     @data = @mints_user.delete_appointment(1)
    def delete_appointment(id)
      return @client.raw("delete", "/config/appointments/#{id}")
    end

    # === Scheduled appointments.
    # Schedule an appointment.
    #
    # ==== Parameters
    # data:: (Hash) -- Data to be submited.
    #
    # ==== Example
    #     data = {
    #       "object_type": "contacts",
    #       "object_id": 1,
    #       "start": "2021-09-06T20:29:16+00:00",
    #       "end": "2022-09-06T20:29:16+00:00"
    #     }
    #     @data = @mints_user.scheduled_appointments(data)
    def scheduled_appointments(data)
      return @client.raw("post", "/config/appointments/scheduled-appointments", nil, data_transform(data))
    end
    
    # === Reschedule appointment.
    # Reschedule an appointment.
    #
    # ==== Parameters
    # data:: (Hash) -- Data to be submited.
    #
    # ==== Example
    #     data = {
    #       "appointment_id": 2,
    #       "start": "2021-09-06T20:29:16+00:00",
    #       "end": "2022-09-06T20:29:16+00:00"
    #     }
    #     @data = @mints_user.reschedule_appointment(data)
    def reschedule_appointment(data)
      return @client.raw("post", "/config/appointments/reschedule-appointment", nil, data_transform(data))
    end
    
    # === Attach invitee.
    # Attach invitee.
    #
    # ==== Parameters
    # data:: (Hash) -- Data to be submited.
    #
    # ==== Example
    #     data = {
    #       "appointment_id": 2,
    #       "invitee_ids": [ 2 ]
    #     }
    #     @data = @mints_user.attach_invitee(data)
    def attach_invitee(data)
      return @client.raw("post", "/config/appointments/attach-invitee", nil, data_transform(data))
    end

    # === Attach follower.
    # Attach follower.
    #
    # ==== Parameters
    # data:: (Hash) -- Data to be submited.
    #
    # ==== Example
    #     data = {
    #       "appointment_id": 2,
    #       "follower_ids": [ 2 ]
    #     }
    #     @data = @mints_user.attach_follower(data)
    def attach_follower(data)
      return @client.raw("post", "/config/appointments/attach-follower", nil, data_transform(data))
    end
    
    # === Detach invitee.
    # Detach invitee.
    #
    # ==== Parameters
    # data:: (Hash) -- Data to be submited.
    #
    # ==== Example
    #     data = {
    #       "appointment_id": 2,
    #       "invitee_ids": [ 2 ]
    #     }
    #     @data = @mints_user.detach_invitee(data)
    def detach_invitee(data)
      return @client.raw("post", "/config/appointments/detach-invitee", nil, data_transform(data))
    end

    # === Detach follower.
    # Detach follower.
    #
    # ==== Parameters
    # data:: (Hash) -- Data to be submited.
    #
    # ==== Example
    #     data = {
    #       "appointment_id": 2,
    #       "follower_ids": [ 2 ]
    #     }
    #     @data = @mints_user.detach_follower(data)
    def detach_follower(data)
      return @client.raw("post", "/config/appointments/detach-follower", nil, data_transform(data))
    end
    
    # === Sync invitee.
    # Sync invitee.
    #
    # ==== Parameters
    # data:: (Hash) -- Data to be submited.
    #
    # ==== Example
    #     data = {
    #       "appointment_id": 2,
    #       "invitee_ids": [ 2 ]
    #     }
    #     @data = @mints_user.sync_invitee(data)
    def sync_invitee(data)
      return @client.raw("post", "/config/appointments/sync-invitee", nil, data_transform(data))
    end
    
    # === Sync follower.
    # Sync follower.
    #
    # ==== Parameters
    # data:: (Hash) -- Data to be submited.
    #
    # ==== Example
    #     data = {
    #       "appointment_id": 2,
    #       "follower_ids": [ 2 ]
    #     }
    #     @data = @mints_user.sync_follower(data)
    def sync_follower(data)
      return @client.raw("post", "/config/appointments/sync-follower", nil, data_transform(data))
    end
    
    ######################################### Profile #########################################


    ##
    # === Me.
    # Get contact logged info.
    #
    # ==== Example
    #     @data = @mints_user.me
    def me
      return @client.raw("get", "/profile/me")
    end

    ##
    # == User Preferences
    #

    ##
    # === Get preferences.
    # Get preferences of current user logged.
    #
    # ==== Example
    #     @data = @mints_user.get_preferences
    def get_preferences
      return @client.raw("get", "/profile/preferences")
    end
    
    ##
    # === Create preferences.
    # Create preferences of current user logged with data.
    #
    # ==== Parameters
    # data:: (Hash) -- Data to be submited.
    #
    # ==== Example
    #     data = {
    #       "time_zone": "GMT-5"
    #     }
    #     @data = @mints_user.create_preferences(data)
    def create_preferences(data)
      return @client.raw("post", "/profile/preferences", nil, data_transform(data))
    end

    ##
    # === Get preferences by setting key.
    # Get preferences using a setting key.
    #
    # ==== Parameters
    # setting_key:: (String) -- Setting key.
    #
    # ==== Example
    #     @data = @mints_user.get_preferences_by_setting_key("time_zone")
    def get_preferences_by_setting_key(setting_key)
      return @client.raw("get", "/profile/preferences/#{setting_key}")
    end

    ##
    # == Notifications
    #

    # === Get notifications.
    # Get a collection of notifications.
    #
    # ==== Example
    #     @data = @mints_user.get_notifications
    def get_notifications
      return @client.raw("get", "/profile/notifications")
    end

    # === Get paginated notifications.
    # Get a collection of paginated notifications.
    #
    # ==== Example
    #     @data = @mints_user.get_paginated_notifications
    def get_paginated_notifications
      return @client.raw("get", "/profile/notificationsp")
    end

    # === Read notifications.
    # Read notifications by data.
    #
    # ==== Parameters
    # data:: (Hash) -- Data to be submited.
    #
    # ==== Example
    #     data = {
    #       "ids": ["406e9b74-4a9d-42f2-afc6-1587bad6147c", "a2d9f582-1bdb-4e55-8af0-cd1962eaa88c"],
    #       "read": true
    #     }
    #     @data = @mints_user.read_notifications(data)
    def read_notifications(data)
      #TODO: Inform NotificationController.read method has been modified
      #TODO: Method in controller didnt return data
      return @client.raw("post", "/profile/notifications/read", nil, data_transform(data))
    end
    
    # === Delete notifications.
    # Delete notifications by data.
    #
    # ==== Parameters
    # data:: (Hash) -- Data to be submited.
    #
    # ==== Example
    #     data = {
    #       "ids": ["179083e3-3678-4cf6-b75e-5a8b9761245e"]
    #     }
    #     @data = @mints_user.delete_notifications(data)
    def delete_notifications(data)
      #TODO: Inform NotificationController.delete method has been modified
      #TODO: Method in controller didnt return data
      return @client.raw("post", "/profile/notifications/delete", nil, data_transform(data))
    end


    ######################################### Helpers #########################################


    ##
    # == Helpers
    #
    
    # === Slugify.
    # Slugify a text using an object type.
    #
    # ==== Parameters
    # options:: (Hash) -- List of {Resource collection Options}[#class-Mints::User-label-Resource+collections+options+] shown above can be used as parameter.
    #
    # ==== Example
    #     options = {
    #       "string": "lego set",
    #       "objectType": "products",
    #       "id": 1
    #     }
    #     @data = @mints_user.slugify(options)
    def slugify(options)
      return @client.raw("get", "/helpers/slugify", options)
    end
    
    # === Get available types from usage.
    # Get available types by usage.
    #
    # ==== Parameters
    # usage:: () -- ...
    #
    def get_available_types_from_usage(usage) #TODO: Research use
      return @client.raw("get", "/helpers/available-types/#{usage}")
    end

    # === Get magic link config.
    # Get config used in magic links.
    #
    # ==== Example
    #     @data = @mints_user.get_magic_link_config
    def get_magic_link_config
      return @client.raw("get", "/helpers/magic-link-config")
    end

    ##
    # == User Folders
    #

    # === Get user folders.
    # Get a collection of user folders.
    #
    # ==== Parameters
    # options:: (Hash) -- List of {Resource collection Options}[#class-Mints::User-label-Resource+collections+options+] shown above can be used as parameter.
    #
    # ==== First Example
    #     @data = @mints_user.get_user_folders
    #
    # ==== Second Example
    #     options = { "fields": "folder" }
    #     @data = @mints_user.get_user_folders(options)
    def get_user_folders(options = nil)
      return @client.raw("get", "/helpers/folders", options)
    end

    # === Get user folder.
    # Get an user folder info.
    #
    # ==== Parameters
    # id:: (Integer) -- User folder id.
    # options:: (Hash) -- List of {Resource collection Options}[#class-Mints::User-label-Resource+collections+options+] shown above can be used as parameter.
    #
    # ==== First Example
    #     @data = @mints_user.get_user_folder(1)
    #
    # ==== Second Example
    #     options = { "fields": "user_id, folder" }
    #     @data = @mints_user.get_user_folder(1, options)
    def get_user_folder(id, options = nil)
      return @client.raw("get", "/helpers/folders/#{id}", options)
    end

    # === Create user folder.
    # Create an user folder with data.
    #
    # ==== Parameters
    # data:: (Hash) -- Data to be submited.
    #
    # ==== Example
    #     data = {
    #       "folder": "new-user-folder",
    #       "object_type": "contacts"
    #     }
    #     @data = @mints_user.create_user_folder(data)
    def create_user_folder(data)
      return @client.raw("post", "/helpers/folders", nil, data_transform(data))
    end

    # === Update user folder.
    # Update an user folder info.
    #
    # ==== Parameters
    # id:: (Integer) -- User folder id.
    # data:: (Hash) -- Data to be submited.
    #
    # ==== Example
    #     data = {
    #       "folder": "new-user-folder-modified",
    #       "object_type": "contacts"
    #     }
    #     @data = @mints_user.update_user_folder(289, data)
    def update_user_folder(id, data)
      return @client.raw("put", "/helpers/folders/#{id}", nil, data_transform(data))
    end

    # === Delete user folder.
    # Delete an user folder.
    #
    # ==== Parameters
    # id:: (Integer) -- User folder id.
    #
    # ==== Example
    #     @data = @mints_user.delete_user_folder(289)
    def delete_user_folder(id)
      return @client.raw("delete", "/helpers/folders/#{id}")
    end

    ##
    # == Object Folders
    #

    # === Get object folders.
    # Get a collection of object folders.
    #
    # ==== Parameters
    # options:: (Hash) -- List of {Resource collection Options}[#class-Mints::User-label-Resource+collections+options+] shown above can be used as parameter.
    #
    # ==== First Example
    #     @data = @mints_user.get_object_folders
    #
    # ==== Second Example
    #     options = { "fields": "id" }
    #     @data = @mints_user.get_object_folders(options)
    def get_object_folders(options = nil)
      return @client.raw("get", "/helpers/object-folders", options)
    end

    # === Get object folder.
    # Get an object folder info.
    #
    # ==== Parameters
    # id:: (Integer) -- Object folders id.
    # options:: (Hash) -- List of {Resource collection Options}[#class-Mints::User-label-Resource+collections+options+] shown above can be used as parameter.
    #
    # ==== First Example
    #     @data = @mints_user.get_object_folder(1)
    #
    # ==== Second Example
    #     options = { "fields": "id" }
    #     @data = @mints_user.get_object_folder(1, options)
    def get_object_folder(id, options = nil)
      return @client.raw("get", "/helpers/object-folders/#{id}", options)
    end

    # === Create object folder.
    # Create an object folder with data.
    #
    # ==== Parameters
    # data:: (Hash) -- Data to be submited.
    #
    # ==== Example
    #     data = {
    #       "folder_id": 1,
    #       "object_id": 1
    #     }
    #     @data = @mints_user.create_object_folder(data)
    def create_object_folder(data)
      return @client.raw("post", "/helpers/object-folders", nil, data_transform(data))
    end

    # === Update object folder.
    # Update an object folder info.
    #
    # ==== Parameters
    # id:: (Integer) -- Object folder id.
    # data:: (Hash) -- Data to be submited.
    #
    # ==== Example
    #     data = {
    #       "folder_id": 2
    #     }
    #     @data = @mints_user.update_object_folder(1, data)
    def update_object_folder(id, data)
      return @client.raw("put", "/helpers/object-folders/#{id}", nil, data_transform(data))
    end

    # === Delete object folder.
    # Delete an object folder.
    #
    # ==== Parameters
    # id:: (Integer) -- Object folder id.
    #
    # ==== Example
    #     @data = @mints_user.delete_object_folder(2)
    def delete_object_folder(id)
      return @client.raw("delete", "/helpers/object-folders/#{id}")
    end

    ##
    # == Object Activities
    #

    # === Get object activities.
    # Get a collection of object activities.
    #
    # ==== Parameters
    # options:: (Hash) -- List of {Resource collection Options}[#class-Mints::User-label-Resource+collections+options+] shown above can be used as parameter.
    #
    # ==== First Example
    #     @data = @mints_user.get_object_activities
    #
    # ==== Second Example
    #     options = { "fields": "object_type" }
    #     @data = @mints_user.get_object_activities(options)
    def get_object_activities(options = nil)
      return @client.raw("get", "/helpers/object-activities", options)
    end

    # === Get object activity.
    # Get an object activity.
    #
    # ==== Parameters
    # id:: (Integer) -- Object activity id.
    # options:: (Hash) -- List of {Resource collection Options}[#class-Mints::User-label-Resource+collections+options+] shown above can be used as parameter.
    #
    # ==== First Example
    #     @data = @mints_user.get_object_activity(1)
    #
    # ==== Second Example
    #     options = { "fields": "activity_type" }
    #     @data = @mints_user.get_object_activity(1, options)
    def get_object_activity(id, options = nil)
      return @client.raw("get", "/helpers/object-activities/#{id}", options)
    end

    # === Create object activity.
    # Create an object activity with data.
    #
    # ==== Parameters
    # data:: (Hash) -- Data to be submited.
    #
    # ==== Example
    #     data = {
    #       "activity_type": "note",
    #       "object_type": "contacts",
    #       "object_id": 1
    #     }
    #     @data = @mints_user.create_object_activity(data)
    def create_object_activity(data)
      return @client.raw("post", "/helpers/object-activities", nil, data_transform(data))
    end
    
    # === Update object activity.
    # Update an object activity info.
    #
    # ==== Parameters
    # id:: (Integer) -- Object activity id.
    # data:: (Hash) -- Data to be submited.
    #
    # ==== Example
    #     data = {
    #       "activity_type": "ticket"
    #     }
    #     @data = @mints_user.update_object_activity(573, data)
    def update_object_activity(id, data)
      return @client.raw("put", "/helpers/object-activities/#{id}", nil, data_transform(data))
    end

    # === Delete object activity.
    # Delete an object activity.
    #
    # ==== Parameters
    # id:: (Integer) -- Object activity id.
    #
    # ==== Example
    #     @data = @mints_user.delete_object_activity(573)
    def delete_object_activity(id)
      return @client.raw("delete", "/helpers/object-activities/#{id}")
    end
    
    ##
    # == Activities
    #

    # === Get activities by object type and id.
    # Get activities using an object type and object type id.
    #
    # ==== Parameters
    # object_type:: (String) -- Object type.
    # id:: (Integer) -- Object type id.
    #
    # ==== Example
    #     @data = @mints_user.get_activities_by_object_type_and_id("contacts", 1)
    def get_activities_by_object_type_and_id(object_type, id)
      return @client.raw("get", "/helpers/activities/#{object_type}/#{id}")
    end

    ##
    # == Dice Coefficient
    #
    
    # === Get dice coefficient.
    # Get dice coefficient.
    #
    # ==== Parameters
    # options:: (Hash) -- List of {Resource collection Options}[#class-Mints::User-label-Resource+collections+options+] shown above can be used as parameter.
    #
    # ==== Example
    #     options = {
    #       "table": "contacts",
    #       "field": "id",
    #       "word": "1"
    #     }
    #     @data = @mints_user.get_dice_coefficient(options)
    def get_dice_coefficient(options)
      return @client.raw("get", "/helpers/dice-coefficient", options)
    end

    ##
    # == Permission
    #

    # === Get permission menu.
    # Get permission menu.
    #
    # ==== Example
    #     @data = @mints_user.get_permission_menu
    def get_permission_menu
      return @client.raw("get", "/helpers/menu")
    end

    ##
    # == Seed
    #

    # === Generate seed.
    # Generate seed using object type and object type id.
    #
    # ==== Parameters
    # objectType:: (String) -- Object type.
    # id:: (Integer) -- Object type id.
    #
    # ==== Example
    #     @data = @mints_user.generate_seed("contacts", 1)
    def generate_seed(objectType, id)
      return @client.raw("get", "/helpers/seeds/#{objectType}/#{id}")
    end
    

    ######################################### Contacts #########################################


    ##
    # == Contact Auth
    #
    
    # === Change password no auth.
    # Change password to an email without auth.
    #
    # ==== Parameters
    # data:: (Hash) -- Data to be submited.
    #
    # ==== Example
    #     data = {
    #       "password": "12345678",
    #       "email": "email@example.com"
    #     }
    #     @data = @mints_user.change_password_no_auth(data)
    def change_password_no_auth(data)
      return @client.raw("post", "/contacts/change-password-no-auth", nil, data_transform(data))
    end


    ######################################### Private #########################################


    private

    # === Get query results.
    # Method used to give the options to make a 'post' or 'get' request.
    #
    # ==== Parameters
    # url:: (String) -- Url to make the request.
    # options:: (Hash) -- List of {Resource collection Options}[#class-Mints::User-label-Resource+collections+options+] shown above can be used as parameter.
    # use_post:: (Boolean) -- Variable to determine if the request is by 'post' or 'get' functions.
    #
    def get_query_results(url, options = nil, use_post = true)
      if use_post
        return @client.raw("post", "#{url}/query", options)
      else
        return @client.raw("get", url, options)
      end
    end

    # === Data transform.
    # Transform a 'data' variable to a standardized 'data' variable.
    #
    # ==== Parameters
    # data:: (Hash) -- Data to be submited.
    #
    def data_transform(data)
      data = correct_json(data)
      unless data[:data]
        data = {data: data}
      end
      return data.to_json
    end

    # === Correct json.
    # Receives a json data and convert it to a symbolized object.
    #
    # ==== Parameters
    # data:: (Hash) -- Data to be submited.
    #
    def correct_json(data)
      if data.is_a? String
        data = JSON.parse(data)
      end
      data = data.symbolize_keys
      return data
    end
    
  end  
end
