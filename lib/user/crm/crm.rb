require_relative './companies'
require_relative './contacts'
require_relative './deals'
require_relative './favorites'
require_relative './segments'
require_relative './users'
require_relative './workflow_step_objects'
require_relative './workflow_steps'
require_relative './workflows'

module CRM
  include Companies
  include Contacts
  include Deals
  include Favorites
  include Segments
  include Users
  include WorkflowStepObjects
  include WorkFlowSteps
  include Workflows
end
