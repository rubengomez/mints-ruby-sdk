require_relative './api_keys.rb'
require_relative './appointments.rb'
require_relative './attribute_groups.rb'
require_relative './attributes.rb'
require_relative './calendars.rb'
require_relative './importers.rb'
require_relative './public_folders.rb'
require_relative './relationships.rb'
require_relative './roles.rb'
require_relative './seeds.rb'
require_relative './system_settings.rb'
require_relative './tags.rb'
require_relative './taxonomies.rb'
require_relative './teams.rb'
require_relative './users.rb'

module Config
    include ApiKeys
    include Appointments
    include AttributeGroups
    include Attributes
    include Calendars
    include Importers
    include PublicFolders
    include Relationships
    include Roles
    include Seeds
    include SystemSettings
    include Tags
    include Taxonomies
    include Teams
    include Users

    ##
    # == Categories
    #

    # def sync_categories_for_object(data)
    #  return @client.raw("put", "/config/categories/sync_categories_for_object", nil, data)
    #end

    # def get_categories_for_object(options)
    #  return @client.raw("get", "/config/categories/get_categories_for_object", options)
    #end
    
    # def get_categories
    #  return @client.raw("get", "/config/categories")
    #end

    # def create_category(data) #TODO: Research if 'visible' is a boolean or int. It accepts smallint
    #  return @client.raw("post", "/config/categories", nil, data)
    #end

    # def update_category(id, data)
    #  return @client.raw("put", "/config/categories/#{id}", nil, data)
    #end

    # def get_category_support_data(id)
    #  return @client.raw("get", "/config/categories/support-data/#{id}")
    #end
    
    # def get_category(id)
    #  return @client.raw("get", "/config/categories/#{id}")
    #end
end