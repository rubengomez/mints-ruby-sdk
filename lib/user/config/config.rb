# frozen_string_literal: true

require_relative './api_keys'
require_relative './appointments'
require_relative './attribute_groups'
require_relative './attributes'
require_relative './calendars'
require_relative './exports'
require_relative './export_configuration'
require_relative './public_folders'
require_relative './relationships'
require_relative './roles'
require_relative './seeds'
require_relative './system_settings'
require_relative './tags'
require_relative './taxonomies'
require_relative './teams'
require_relative './users'

module Config
  include ApiKeys
  include Appointments
  include AttributeGroups
  include Attributes
  include Calendars
  include Exports
  include ExportConfiguration
  include PublicFolders
  include Relationships
  include Roles
  include Seeds
  include SystemSettings
  include Tags
  include Taxonomies
  include Teams
  include Users
end
