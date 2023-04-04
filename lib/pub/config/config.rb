# frozen_string_literal: true

### V1/CONFIG ###

require_relative './attributes'
require_relative './public_folders'
require_relative './tags'
require_relative './taxonomies'

module PublicConfig
  include PublicAttributes
  include PublicFolders
  include PublicTags
  include PublicTaxonomies
end
