# frozen_string_literal: true

### V1/CONTENT ###

require_relative './assets'
require_relative './content_bundles'
require_relative './content_instance_versions'
require_relative './content_instances'
require_relative './forms'
require_relative './stories'
require_relative './story_versions'

module Content
  include Assets
  include ContentBundles
  include ContentInstanceVersions
  include ContentInstances
  include Forms
  include Stories
  include StoryVersions

end
