require_relative './companies.rb'
require_relative './contacts.rb'
require_relative './deals.rb'
require_relative './favorites.rb'
require_relative './segments.rb'
require_relative './users.rb'
require_relative './workflow_step_objects.rb'
require_relative './workflow_steps.rb'
require_relative './workflows.rb'

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