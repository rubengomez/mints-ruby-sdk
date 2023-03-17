module Roles
    ##
    # == Roles
    #

    #def get_roles_permissions #FIXME: RoleController doesnt have getPermissions method
    #  @client.raw("get", "/config/roles/get-permissions")
    #end

    # === Duplicate role.
    # Duplicate a role.
    #
    # ==== Parameters
    # id:: (Integer) -- Role id.
    # data:: (Hash) -- Data to be submitted.
    #
    # ==== Example
    #     data = { 
    #       "options": [] 
    #     }
    #     @data = @mints_user.duplicate_role(1, data.to_json)
    def duplicate_role(id, data)
        @client.raw("post", "/config/roles/#{id}/duplicate", nil, data)
    end
    
    # === Get roles.
    # Get a collection of roles.
    #
    # ==== Example
    #     @data = @mints_user.get_roles
    def get_roles
        @client.raw("get", "/config/roles")
    end

    # === Get role.
    # Get a role info.
    #
    # ==== Parameters
    # id:: (Integer) -- Role id.
    # options:: (Hash) -- List of Resource Collection Options shown above can be used as parameter.
    #
    # ==== Example
    #     @data = @mints_user.get_role(1)
    def get_role(id)
        @client.raw("get", "/config/roles/#{id}")
    end

    # === Create role.
    # Create a role with data.
    #
    # ==== Parameters
    # data:: (Hash) -- Data to be submitted.
    #
    # ==== Example
    #     data = {
    #       "name": "new-role",
    #       "display_name": "New Role",
    #       "description": "Role description"
    #     }
    #     @data = @mints_user.create_role(data)
    def create_role(data)
        @client.raw("post", "/config/roles", nil, data_transform(data))
    end
    
    # === Update role.
    # Update a role info.
    #
    # ==== Parameters
    # id:: (Integer) -- Role id.
    # data:: (Hash) -- Data to be submitted.
    #
    # ==== Example
    #     data = {
    #       "name": "new-role",
    #       "display_name": "New Role Display Name Modified",
    #       "description": "Role description",
    #       "permissions": 1
    #     }
    #     @data = @mints_user.update_role(8, data)
    def update_role(id, data) #FIXME: This action is unauthorized
        #TODO: Research permissions variable type. This would be the error's solution.
        @client.raw("put", "/config/roles/#{id}", nil, data_transform(data))
    end
end