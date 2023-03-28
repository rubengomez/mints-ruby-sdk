# frozen_string_literal: true

### V1/CONFIG ###

require_relative './attributes'
require_relative './public_folders'
require_relative './tags'
require_relative './taxonomies'

module Config
  include Attributes
  include PublicFolders
  include Tags
  include Taxonomies
end
