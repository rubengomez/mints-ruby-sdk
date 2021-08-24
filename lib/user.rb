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

    ##
    # === Me.
    # Get contact logged info
    #
    def me
      return @client.get__profile__me
    end
    ######################################### CRM #########################################
    
    #TODO: Add options to every method and test
    
    ##
    # == Contacts
    #

    def get_support_datas #TODO: rename
      return @client.raw("get", "/crm/contacts/support-data")
    end
    
    def get_online_activity(id)
      return @client.raw("get", "/crm/contacts/#{id}/online-activity")
    end

    ##
    # === Get contacts.
    # Get a collection of contacts
    #
    # ==== Parameters
    # * +options+ - [Hash] List of {Resource collection Options}[#class-Mints::User-label-Resource+collections+options+] shown above can be used as parameter
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

    def get_segment_attributes(data, options = nil) #FIXME: method doesn't work because cannot send data in get
      return @client.raw("get", "/crm/segments/attributes", options, data)
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

    def get_dam #FIXME: Method works but response is a html document.
      return @client.raw("get", "/content/dam")
    end

    def get_dam_loadtree
      return @client.raw("get", "/content/dam/loadtree")
    end

    def get_dam_asset_locations(data) #FIXME: Get cannot receive data
      return @client.raw("get", "/content/dam/asset-locations", nil, data)
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

    def get_asset_thumbnails(id) #FIXME: DOESNT RETURN JSON, RETURN AN IMAGE
      return @client.raw("get", "/content/assets/thumbnails/#{id}")
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

    def get_asset_sizes(data) #FIXME: Get cannot receive data
      return @client.raw("get", "/content/assets/getSizes", nil, data)
    end

    def get_asset_usage(data) #FIXME: Get cannot receive data
      return @client.raw("get", "/content/assets/usage", nil, data)
    end

    def delete_asset_variation #TODO: Not tested
      return @client.raw("get", "/content/assets/deleteVariation")
    end

    def delete_asset_size #TODO: Not tested
      return @client.raw("get", "/content/assets/deleteSize")
    end

    def get_asset_info(data) #FIXME: Get cannot receive data
      return @client.raw("get", "/content/assets/getAssetInfo", nil, data)
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

    def get_content_pages_from_email_template(id) #FIXME: ContentController doesnt have getContentPage mathod
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
    
  end  
end
