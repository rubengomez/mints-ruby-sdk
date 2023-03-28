# frozen_string_literal: true

require_relative './object_activities'
require_relative './object_folders'
require_relative './user_folders'

module Helpers
  include ObjectActivities
  include ObjectFolders
  include UserFolders

  ##
  # == Helpers
  #

  # === Slugify.
  # Slugify a text using an object type.
  #
  # ==== Parameters
  # data:: (Hash) -- Data to be submitted.
  #
  # ==== Example
  #
  def slugify(data)
    # TODO: Research use of variable polymorphicObjectType
    @client.raw('post', '/helpers/slugify', nil, data_transform(data))
  end

  # === Get available types from usage.
  # Get available types by usage.
  #
  # ==== Parameters
  # usage:: () -- ...
  #
  def get_available_types_from_usage(usage)
    # TODO: Research use
    @client.raw('get', "/helpers/available-types/#{usage}")
  end

  # === Get magic link config.
  # Get config used in magic links.
  #
  # ==== Example
  #     @data = @mints_user.get_magic_link_config
  def get_magic_link_config
    @client.raw('get', '/helpers/magic-link-config')
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
  #     @data = @mints_user.get_activities_by_object_type_and_id('contacts', 1)
  def get_activities_by_object_type_and_id(object_type, id)
    @client.raw('get', "/helpers/activities/#{object_type}/#{id}")
  end

  ##
  # == Dice Coefficient
  #

  # === Get dice coefficient.
  # Get dice coefficient.
  #
  # ==== Parameters
  # options:: (Hash) -- List of Resource Collection Options shown above can be used as parameter.
  #
  # ==== Example
  #     options = {
  #       table: 'contacts',
  #       field: 'id',
  #       word: '1'
  #     }
  #     @data = @mints_user.get_dice_coefficient(options)
  def get_dice_coefficient(options)
    @client.raw('get', '/helpers/dice-coefficient', options)
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
    @client.raw('get', '/helpers/menu')
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
  #     @data = @mints_user.generate_seed('contacts', 1)
  def generate_seed(object_type, id)
    @client.raw('get', "/helpers/seeds/#{object_type}/#{id}")
  end
end
