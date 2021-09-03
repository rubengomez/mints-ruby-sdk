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
    
    #TODO: Add options to every method and test
    
    ##
    # == Contacts
    #

    ##
    # === Get contacts support data.
    #
    # ==== Example
    #     @data = @mints_user.get_support_datas
    def get_support_datas #TODO: ask for rename
      return @client.raw("get", "/crm/contacts/support-data")
    end
    
    ##
    # === Get contacts online activity.
    #
    # ==== Parameters
    # * +id+ - [Integer] Contact id
    #
    # ==== Example
    #     @data = @mints_user.get_online_activity(5)
    def get_online_activity(id)
      return @client.raw("get", "/crm/contacts/#{id}/online-activity")
    end

    ##
    # === Get contacts.
    # Get a collection of contacts
    #
    # ==== Parameters
    # * +options+ - [Hash] List of {Resource collection Options}[#class-Mints::User-label-Resource+collections+options+] shown above can be used as parameter
    #
    # ==== First Example
    #     @data = @mints_user.get_contacts
    # ==== Second Example
    #     options = { 
    #       "sort": "id",
    #       "fields[contacts]": "id, email"
    #     }
    #     @data = @mints_user.get_contacts(options)
    def get_contacts(options = nil)
      return @client.raw("get", "/crm/contacts", options)
    end

    def get_contact(id, options = nil)
      return @client.raw("get", "/crm/contacts/#{id}", options)
    end

    def create_contact(data, options = nil)
      return @client.raw("post", "/crm/contacts", options, data)
    end

    def update_contact(id, data, options = nil)
      return @client.raw("put", "/crm/contacts/#{id}", options, data)
    end

    def get_contact_deals(contact_id)
      return @client.raw("get", "/crm/contacts/#{contact_id}/deals")
    end

    def create_contact_deals(contact_id, data)
      return @client.raw("post", "/crm/contacts/#{contact_id}/deals", nil, data)
    end

    def delete_contact_deals(contact_id, data) #FIXME: MethodNotAllowedHttpException
      return @client.raw("delete", "/crm/contacts/#{contact_id}/deals", nil, data)
    end

    def get_contact_users(contact_id, options = nil)
      return @client.raw("get", "/crm/contacts/#{contact_id}/users", options)
    end

    def create_contact_users(contact_id, data)
      return @client.raw("post", "/crm/contacts/#{contact_id}/users", nil, data)
    end

    def delete_contact_users(contact_id, data) #FIXME: MethodNotAllowedHttpException
      return @client.raw("delete", "/crm/contacts/#{contact_id}/users", nil, data)
    end

    def get_contact_segments(contact_id)
      return @client.raw("get", "/crm/contacts/#{contact_id}/segments")
    end

    def get_contact_submissions(contact_id)
      return @client.raw("get", "/crm/contacts/#{contact_id}/submissions")
    end

    def get_contact_tags(contact_id)
      return @client.raw("get", "/crm/contacts/#{contact_id}/tags")
    end

    def get_contact_magic_links(contact_id)
      return @client.raw("get", "/crm/contacts/#{contact_id}/magic-links")
    end

    def create_contact_merge(id, data)
      return @client.raw("post", "/crm/contacts/#{id}/merge")
    end

    def send_magic_links(data)
      return @client.raw("post", "/crm/contacts/send-magic-link", nil, data)
    end

    ##
    # == Contacts Bulk Actions
    #

    def delete_contacts(data)
      return @client.raw("delete", "/crm/contacts/delete", nil, data)
    end

    ##
    # == Deals
    #

    def get_deal_permits(id)
      return @client.raw("get", "/crm/deals/#{id}/permits")
    end

    def get_deal_support_data
      return @client.raw("get", "/crm/deals/support-data")
    end

    def get_deal_currencies
      return @client.raw("get", "/crm/deal/currencies")
    end

    # === Get deals.
    # Get a collection of deals
    #
    # ==== Parameters
    # * +options+ - [Hash] List of {Resource collection Options}[#class-Mints::User-label-Resource+collections+options+] shown above can be used as parameter
    def get_deals(options = nil)
      return @client.raw("get", "/crm/deals", options)
    end

    def get_deal(id, options = nil)
      return @client.raw("get", "/crm/deals/#{id}", options)
    end

    def create_deal(data)
      return @client.raw("post", "/crm/deals", nil, data)
    end

    def update_deal(id, data)
      return @client.raw("put", "/crm/deals/#{id}", nil, data)
    end

    ##
    # == Companies
    #

    def get_companies_support_data
      return @client.raw("get", "/crm/companies/support-data")
    end

    # === Get companies.
    # Get a collection of companies
    #
    # ==== Parameters
    # * +options+ - [Hash] List of {Resource collection Options}[#class-Mints::User-label-Resource+collections+options+] shown above can be used as parameter
    def get_companies(options = nil)
      return @client.raw("get", "/crm/companies", options)
    end

    def get_company(id, options = nil)
      return @client.raw("get", "/crm/companies/#{id}", options)
    end

    def create_company(data)
      return @client.raw("post", "/crm/companies/", nil, data)
    end

    def update_company(id, data)
      return @client.raw("put", "/crm/companies/#{id}", nil, data)
    end

    ##
    # == Companies Bulk Actions
    #

    def delete_companies(data)
      return @client.raw("delete", "/crm/companies/delete", nil, data)
    end

    ##
    # == Workflows
    #

    def get_workflows(options = nil)
      return @client.raw("get", "/crm/workflows", options)
    end

    def get_workflow(id, options = nil)
      return @client.raw("get", "/crm/workflows/#{id}", options)
    end

    def create_workflow(data)
      return @client.raw("post", "/crm/workflows/", nil, data)
    end

    def update_workflow(id, data)
      return @client.raw("put", "/crm/workflows/#{id}", nil, data)
    end

    ##
    # == Workflow Step Objects
    #

    def get_step_objects(options = nil)
      return @client.raw("get", "/crm/step-objects", options)
    end

    def get_step_object(id, options = nil)
      return @client.raw("get", "/crm/step-objects/#{id}", options)
    end

    def create_step_object(data)
      return @client.raw("post", "/crm/step-objects/", nil, data)
    end

    def update_step_object(id, data)
      return @client.raw("put", "/crm/step-objects/#{id}", nil, data)
    end

    def get_step_object_by_object_type(objectType, objectId, options = nil)
      return @client.raw("get", "/crm/step-objects/#{objectType}/#{objectId}", options)
    end

    ##
    # == Workflow Steps
    #

    def create_workflow_step(data)
      return @client.raw("post", "/crm/steps", nil, data)
    end

    def update_workflow_step(id, data)
      return @client.raw("put", "/crm/steps/#{id}", nil, data)
    end

    def delete_workflow_step(id) #FIXME: DELETE DOESN'T WORK
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

    def get_segment_support_datas
      return @client.raw("get", "/crm/segments/support-data")
    end

    def get_segment_attributes(options = nil)
      return @client.raw("get", "/crm/segments/attributes", options)
    end

    def get_segment_group(groupId)
      return @client.raw("get", "/crm/segments/groups/#{groupId}")
    end

    def duplicate_segment(id, data)
      return @client.raw("post", "/crm/segments/#{id}/duplicate", nil, data)
    end
    
    def get_segments(options = nil)
      return @client.raw("get", "/crm/segments", options)
    end

    def get_segment(id, options = nil)
      return @client.raw("get", "/crm/segments/#{id}", options)
    end

    def create_segment(data)
      return @client.raw("post", "/crm/segments", nil, data)
    end

    def update_segment(id, data)
      return @client.raw("put", "/crm/segments/#{id}", nil, data)
    end

    def delete_segment(id)
      return @client.raw("delete", "/crm/segments/#{id}")
    end

    ##
    # == Users
    #

    def get_users(options = nil)
      return @client.raw("get", "/crm/users", options, nil)
    end


    ######################################### Content #########################################
    
    
    ##
    # == Pages
    #

    def get_pages_groups
      return @client.raw("get", "/content/pages/groups")
    end

    def get_pages
      return @client.raw("get", "/content/pages")
    end

    def get_page(id)
      return @client.raw("get", "/content/pages/#{id}")
    end

    def create_page(data)
      return @client.raw("post", "/content/pages", nil, data)
    end

    def update_page(id, data)
      return @client.raw("put", "/content/pages/#{id}", nil, data)
    end

    def delete_page(id)
      return @client.raw("delete", "/content/pages/#{id}")
    end

    ##
    # == Forms
    #

    def get_forms(options = nil)
      return @client.raw("get", "/content/forms", options)
    end

    def get_form(id, options = nil)
      return @client.raw("get", "/content/forms/#{id}", options)
    end

    def duplicate_form(id)
      return @client.raw("post", "/content/forms/#{id}/duplicate")
    end

    def get_form_support_data()
      return @client.raw("get", "/content/forms/support-data")
    end

    def get_form_submissions(options = nil)
      return @client.raw("get", "/content/forms/submissions", options)
    end

    def create_form(data)
      return @client.raw("post", "/content/forms", nil, data)
    end

    def update_form(id, data)
      return @client.raw("put", "/content/forms/#{id}", nil, data)
    end

    def delete_form(id)
      return @client.raw("delete", "/content/forms/#{id}")
    end

    ##
    # == Content templates
    #

    def get_content_template_instances(templateId)
      return @client.raw("get", "/content/templates/#{templateId}/instances")
    end

    def duplicate_content_template(id)
      return @client.raw("post", "/content/templates/#{id}/duplicate/")
    end

    # === Get content templates.
    # Get a collection of content templates
    #
    # ==== Parameters
    # * +options+ - [Hash] List of {Resource collection Options}[#class-Mints::User-label-Resource+collections+options+] shown above can be used as parameter
    def get_content_templates(options = nil)
      return @client.raw("get", "/content/templates", options)
    end

    def get_content_template(id)
      return @client.raw("get", "/content/templates/#{id}")
    end

    def create_content_template(data)
      #FIXME: Method doesn't work, controller cannot get template info from request variable.
      return @client.raw("post", "/content/templates", nil, data)
    end

    def update_content_template(id, data)
       #FIXME: Method doesn't work, controller cannot get template info from request variable.
      return @client.raw("put", "/content/templates/#{id}", nil, data)
    end

    def delete_content_template(id)
      #TODO: NOT TESTED
      return @client.raw("delete", "/content/templates/#{id}")
    end

    ##
    # == Content Instances
    #

    # === Get content instances.
    # Get a collection of content instances
    #
    # ==== Parameters
    # * +options+ - [Hash] List of {Resource collection Options}[#class-Mints::User-label-Resource+collections+options+] shown above can be used as parameter
    def get_content_instances(options = nil)
      return @client.raw("get", "/content/instances", options)
    end

    def duplicate_content_instance(id, data)
      return @client.raw("post", "/content/instances/#{id}/duplicate", nil, data)
    end
    
    def get_content_instance(id, options = nil)
      return @client.raw("get", "/content/instances/#{id}", options)
    end

    def publish_content_instance(id, data)
      return @client.raw("put", "/content/instances/#{id}/publish", nil, data)
    end

    def schedule_content_instance(id, data) #FIXME: Undefined index: scheduled_at
      return @client.raw("put", "/content/instances/#{id}/schedule", nil, data)
    end

    def revert_published_data_from_content_instance(id)
      return @client.raw("get", "/content/instances/#{id}/revert-published-data")
    end

    def create_content_instance(data)
      return @client.raw("post", "/content/instances",  nil, data)
    end

    def update_content_instance(id, data)
      return @client.raw("put", "/content/instances/#{id}", nil, data)
    end

    def delete_content_instance(id)
      return @client.raw("delete", "/content/instances/#{id}")
    end

    ##
    # == OTHER
    #

    def get_authors
      return @client.raw("get", "/content/authors")
    end

    def get_keywords(options = nil)
      return @client.raw("get", "/content/keywords", options)
    end

    def get_public_images_url
      return @client.raw("get", "/content/public-images-url")
    end

    def get_stages(options = nil)
      return @client.raw("get", "/content/stages", options)
    end

    ##
    # == dam
    #

    def get_dam_loadtree
      return @client.raw("get", "/content/dam/loadtree")
    end

    def get_dam_asset_locations(options)
      return @client.raw("get", "/content/dam/asset-locations", options)
    end
    
    def paste_dam(data) #FIXME: Invalid argument supplied for foreach()
      return @client.raw("post", "/content/dam/paste", nil, data)
    end

    def rename_dam(data) #TODO: No validate
      return @client.raw("post", "/content/dam/rename", nil, data)
    end

    def search_dam(data)
      return @client.raw("post", "/content/dam/search", nil, data)
    end

    def send_to_trash_dam(data) #FIXME: Invalid argument supplied for foreach()
      return @client.raw("post", "/content/dam/sendToTrash", nil, data)
    end

    def delete_dam(data) #FIXME: Invalid argument supplied for foreach()
      return @client.raw("post", "/content/dam/delete", nil, data)
    end

    def create_dam_folder(data)
      return @client.raw("post", "/content/folders/create", nil, data)
    end

    ##
    # == Assets
    #

    def create_asset(data) #TODO: ask for renaming to 'upload asset'
      return @client.raw("post", "/content/assets/upload", nil, data)
    end

    def get_asset_link_info(data)
      return @client.raw("post", "/content/assets/getLinkInfo", nil, data)
    end

    def download_asset(id) #FIXME: File not found at path
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

    def get_support_data_of_story_template(id)
      return @client.raw("get", "/content/story-templates/support-data/stories/#{id}")
    end

    def get_support_data_of_story_templates
      return @client.raw("get", "/content/story-templates/support-data")
    end

    def get_story_templates(options = nil)
      return @client.raw("get", "/content/story-templates", options)
    end

    def get_story_template(id, options = nil)
      return @client.raw("get", "/content/story-templates/#{id}", options)
    end

    def create_story_template(data)
      return @client.raw("post", "/content/story-templates", nil, data)
    end

    def update_story_template(id, data) #FIXME: InternalServerError
      return @client.raw("put", "/content/story-templates/#{id}", nil, data)
    end

    ##
    # == Story
    #

    def publish_story(id, data) #FIXME: Invalid argument supplied for foreach()
      return @client.raw("put", "/content/stories/#{id}/publish", nil, data)
    end

    def schedule_story(id, data) #FIXME: Invalid argument supplied for foreach()
      return @client.raw("put", "/content/stories/#{id}/schedule", nil, data)
    end

    def revert_published_story(id)
      return @client.raw("get", "/content/stories/#{id}/revert-published-data")
    end

    def get_story_support_data
      return @client.raw("get", "/content/stories/support-data")
    end

    def duplicate_story(id, data)
      return @client.raw("post", "/content/stories/#{id}/duplicate", nil, data)
    end

    def get_stories(options = nil)
      return @client.raw("get", "/content/stories", options)
    end

    def get_story(id, options = nil)
      return @client.raw("get", "/content/stories/#{id}", options)
    end

    def create_story(data)
      return @client.raw("post", "/content/stories", nil, data)
    end

    def update_story(id, data) #FIXME: InternalServerError
      return @client.raw("put", "/content/stories/#{id}", nil, data)
    end

    def delete_story(id)
      return @client.raw("delete", "/content/stories/#{id}")
    end

    ##
    # == Email Template
    #

    def get_content_pages_from_email_template(id) #FIXME: ContentController doesnt have getContentPage method
      return @client.raw("get", "/content/email-templates/content-pages/#{id}")
    end

    def get_variables_of_content_pages_from_email_template(id)
      return @client.raw("get", "/content/email-templates/content-pages/#{id}/variables")
    end

    def get_recipient_variables
      return @client.raw("get", "/content/email-templates/recipient-variables")
    end
    
    def get_driver_templates
      return @client.raw("get", "/content/email-templates/driver/templates")
    end

    def preview_email_template(data)
      return @client.raw("post", "/content/email-templates/preview", nil, data)
    end

    def send_email_template(data)
      return @client.raw("post", "/content/email-templates/send", nil, data)
    end

    def duplicate_email_template(id, data)
      return @client.raw("post", "/content/email-templates/#{id}/duplicate", nil, data)
    end

    def get_email_templates(options = nil)
      return @client.raw("get", "/content/email-templates", options)
    end

    def get_email_template(id, options = nil)
      return @client.raw("get", "/content/email-templates/#{id}", options)
    end

    def create_email_template(data)
      return @client.raw("post", "/content/email-templates", nil, data)
    end

    def update_email_template(id, data)
      return @client.raw("put", "/content/email-templates/#{id}", nil, data)
    end

    def delete_email_template(id)
      return @client.raw("delete", "/content/email-templates/#{id}")
    end

    ##
    # == Keywords
    #

    def get_keyword(id)
      return @client.raw("get", "/content/keywords/#{id}")
    end

    def create_keyword(data)
      return @client.raw("post", "/content/keywords", nil, data)
    end

    def update_keyword(id, data) #FIXME: Method doesn't work, controller cannot get keyword info from request variable.
      return @client.raw("put", "/content/keywords/#{id}", nil, data)
    end

    ##
    # == Authors
    #

    def get_author(id)
      return @client.raw("get", "/content/authors/#{id}")
    end

    def create_author(data)
      return @client.raw("post", "/content/authors", nil, data)
    end

    def update_author(id, data) #FIXME: Method doesn't work, controller cannot get author data from request variable.
      return @client.raw("put", "/content/authors/#{id}", nil, data)
    end

    ##
    # == Stages
    #

    def get_stage(id)
      return @client.raw("get", "/content/stages/#{id}")
    end

    def create_stage(data) #FIXME: Cannot insert data into database successfully
      return @client.raw("post", "/content/stages", nil, data)
    end

    def update_stage(id, data) #FIXME: Method doesn't work, controller cannot get stage data from request variable.
      return @client.raw("put", "/content/stages/#{id}", nil, data)
    end


    ######################################### Marketing #########################################


    ##
    # == Automation
    #

    def get_automations(options = nil)
      return @client.raw("get", "/marketing/automation", options)
    end

    def get_automation(id, options = nil)
      return @client.raw("get", "/marketing/automation/#{id}", options)
    end

    def create_automation(data)
      return @client.raw("post", "/marketing/automation/", nil, data)
    end

    def update_automation(id, data) #FIXME: Method doesn't work, controller cannot get automation data from request variable.
      return @client.raw("put", "/marketing/automation/#{id}", nil, data)
    end

    def delete_automation(id)
      return @client.raw("delete", "/marketing/automation/#{id}")
    end

    def get_automation_executions(id)
      return @client.raw("get", "/marketing/automation/#{id}/executions")
    end
    
    def reset_automation(id)
      return @client.raw("post", "/marketing/automation/#{id}/reset")
    end
    
    def duplicate_automation(id, data)
      return @client.raw("post", "/marketing/automation/#{id}/duplicate", nil, data)
    end


    ######################################### Ecommerce #########################################


    ##
    # == Price List
    #

    def get_price_lists(options = nil)
      return @client.raw("get", "/ecommerce/price-list", options)
    end

    def get_price_list(id, options = nil)
      return @client.raw("get", "/ecommerce/price-list/#{id}", options)
    end

    def create_price_list(data)
      return @client.raw("post", "/ecommerce/price-list", nil, data)
    end

    def update_price_list(id, data)
      return @client.raw("put", "/ecommerce/price-list/#{id}", nil, data)
    end

    ##
    # == Product
    #

    def update_product_variations_config(productId, data) #TODO: Research use
      return @client.raw("post", "/ecommerce/products/update-variations-config/#{productId}", nil, data)
    end

    def get_product_support_data
      return @client.raw("get", "/ecommerce/products/support-data")
    end

    def delete_product(id)
      return @client.raw("delete", "/ecommerce/products/#{id}")
    end
    
    def publish_product(id, data) #TODO: Research data in publish
      return @client.raw("put", "/ecommerce/products/#{id}/publish", nil, data)
    end

    def schedule_product(id, data)
      return @client.raw("put", "/ecommerce/products/#{id}/schedule", nil, data)
    end

    def get_product_variant_options_config(id)
      return @client.raw("get", "/ecommerce/products/#{id}/variant-options-config")
    end

    def revert_published_data(id)
      return @client.raw("get", "/ecommerce/products/#{id}/revert-published-data")
    end
    
    def get_products(options = nil)
      return @client.raw("get", "/ecommerce/products", options)
    end

    def get_product(id, options = nil)
      return @client.raw("get", "/ecommerce/products/#{id}", options)
    end

    def create_product(data)
      return @client.raw("post", "/ecommerce/products/", nil, data)
    end

    def update_product(id, data)
      return @client.raw("put", "/ecommerce/products/#{id}", nil, data)
    end
    
    ##
    # == Locations
    #

    def get_locations
      return @client.raw("get", "/ecommerce/locations")
    end
    
    def get_location(id)
      return @client.raw("get", "/ecommerce/locations/#{id}")
    end

    def create_location(data)
      return @client.raw("post", "/ecommerce/locations", nil, data)
    end

    def update_location(id, data)
      return @client.raw("put", "/ecommerce/locations/#{id}", nil, data)
    end

    def delete_location(id)
      return @client.raw("delete", "/ecommerce/locations/#{id}")
    end

    ##
    # == Locations Templates
    #

    def get_location_template_support_data(id)
      return @client.raw("get", "/ecommerce/location-templates/#{id}/support-data")
    end
    
    def get_location_templates_support_data
      return @client.raw("get", "/ecommerce/location-templates/support-data")
    end

    def get_location_templates(options = nil)
      return @client.raw("get", "/ecommerce/location-templates", options)
    end

    def get_location_template(id, options = nil)
      return @client.raw("get", "/ecommerce/location-templates/#{id}", options)
    end
    
    def create_location_template(data)
      return @client.raw("post", "/ecommerce/location-templates", nil, data)
    end
    
    def update_location_template(id, data)
      return @client.raw("put", "/ecommerce/location-templates/#{id}", nil, data)
    end
    
    ##
    # == Product Variation
    #

    def generate_product_variation(productId, data) #FIXME: Error
      return @client.raw("post", "/ecommerce/product-variations/generate/#{productId}", nil, data)
    end

    def set_prices_to_product_variations(data)
      return @client.raw("post", "/ecommerce/product-variations/set-prices", nil, data)
    end

    def get_product_from_product_variation(productId)
      return @client.raw("get", "/ecommerce/product-variations/product/#{productId}")
    end

    def get_product_variations(options = nil)
      return @client.raw("get", "/ecommerce/product-variations", options)
    end

    def get_product_variation(id)
      return @client.raw("get", "/ecommerce/product-variations/#{id}")
    end

    def create_product_variation(data) #FIXME: Cannot validate price
      return @client.raw("post", "/ecommerce/product-variations", nil, data)
    end

    def update_product_variation(id, data) #TODO: Not tested
      return @client.raw("put", "/ecommerce/product-variations/#{id}", nil, data)
    end

    def delete_product_variation(id) #TODO: Not tested
      return @client.raw("delete", "/ecommerce/product-variations/#{id}")
    end
    
    ##
    # == Variant Options
    #

    def get_variant_options(options = nil)
      return @client.raw("get", "/ecommerce/variant-options", options)
    end

    def get_variant_option(id, options = nil)
      return @client.raw("get", "/ecommerce/variant-options/#{id}", options)
    end
    
    def create_variant_option(data)
      return @client.raw("post", "/ecommerce/variant-options", nil, data)
    end
    
    def update_variant_option(id, data)
      return @client.raw("put", "/ecommerce/variant-options/#{id}", nil, data)
    end
    
    def get_can_remove_variant_option(id) #FIXME: VariantOptionController doesnt have canRemove method
      return @client.raw("get", "/ecommerce/variant-options/can-remove/#{id}")
    end

    ##
    # == Variant Values
    #
    
    def get_variant_values(options = nil)
      return @client.raw("get", "/ecommerce/variant-values", options)
    end
    
    def get_variant_value(id, options = nil)
      return @client.raw("get", "/ecommerce/variant-values/#{id}", options)
    end

    def create_variant_value(data)
      return @client.raw("post", "/ecommerce/variant-values", nil, data)
    end

    def update_variant_value(id, data)
      return @client.raw("put", "/ecommerce/variant-values/#{id}", nil, data)
    end
    
    ##
    # == Product Templates
    #

    def get_product_templates_support_data_from_product(id)
      return @client.raw("get", "/ecommerce/product-templates/support-data/products/#{id}")
    end

    def get_product_templates_support_data_from_order_items_group(id)
      return @client.raw("get", "/ecommerce/product-templates/support-data/order-items-groups/#{id}")
    end

    def get_product_templates_support_data
      return @client.raw("get", "/ecommerce/product-templates/support-data")
    end
    
    def get_product_templates(options = nil)
      return @client.raw("get", "/ecommerce/product-templates", options)
    end

    def get_product_template(id, options = nil)
      return @client.raw("get", "/ecommerce/product-templates/#{id}", options)
    end
    
    def create_product_template(data)
      return @client.raw("post", "/ecommerce/product-templates/", nil, data)
    end
    
    def update_product_template(id, data)
      return @client.raw("put", "/ecommerce/product-templates/#{id}", nil, data)
    end

    ##
    # == Orders
    #

    def duplicate_order(orderId, data) #FIXME: Doesnt read options from data and sale_price_cents column doesnt have to be null
      return @client.raw("post", "/ecommerce/orders/duplicate/#{orderId}", nil, data)
    end

    def delete_orders(data) #TODO: Method should return another response like 'success'
      return @client.raw("delete", "/ecommerce/orders/delete", nil, data)
    end
    
    def get_orders_support_data
      return @client.raw("get", "/ecommerce/orders/support-data")
    end
    
    def get_orders(options = nil)
      return @client.raw("get", "/ecommerce/orders", options)
    end

    def get_order(id, options = nil)
      return @client.raw("get", "/ecommerce/orders/#{id}", options)
    end

    def create_order(data)
      return @client.raw("post", "/ecommerce/orders", nil, data)
    end

    def update_order(id, data)
      return @client.raw("put", "/ecommerce/orders/#{id}", nil, data)
    end
    
    ##
    # == Order Templates
    #
    
    def get_order_template_support_data(id)
      return @client.raw("get", "/ecommerce/order-templates/support-data/#{id}")
    end

    def get_order_templates(options = nil)
      return @client.raw("get", "/ecommerce/order-templates", options)
    end

    def get_order_template(id, options = nil)
      return @client.raw("get", "/ecommerce/order-templates/#{id}", options)
    end
    
    def update_order_templates(id, data)
      return @client.raw("put", "/ecommerce/order-templates/#{id}", nil, data)
    end

    ##
    # == Order Items
    #

    def get_order_items_support_data
      return @client.raw("get", "/ecommerce/order-items/support-data")
    end
    
    def detach_order_item_from_order_item_group(orderItemId, groupId) #TODO: Not tested
      return @client.raw("put", "/ecommerce/order-items/detach/#{orderItemId}/order-items-groups/#{groupId}")
    end

    def update_order_item_from_order_item_group(orderItemId, groupId) #TODO: Not tested
      return @client.raw("put", "/ecommerce/order-items/update/#{orderItemId}/order-items-groups/#{groupId}")
    end
    
    def get_order_items(options = nil)
      return @client.raw("get", "/ecommerce/order-items", options)
    end

    def get_order_item(id, options = nil)
      return @client.raw("get", "/ecommerce/order-items/#{id}", options)
    end
    
    def update_order_item(id, data) #TODO: Research what can update
      return @client.raw("put", "/ecommerce/order-items/#{id}", nil, data)
    end

    ##
    # == Order Items Groups
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
    
  end  
end
