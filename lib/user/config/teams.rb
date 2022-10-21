module Teams
    ##
    # == Teams
    #
    
    # === Get team types.
    # Get a collection of team types.
    #
    # ==== Example
    #     @data = @mints_user.get_team_types
    def get_team_types
        return @client.raw("get", "/config/teams/team-types")
    end
    
    # === Get teams.
    # Get a collection of teams.
    #
    # ==== Example
    #     @data = @mints_user.get_teams
    def get_teams
        return @client.raw("get", "/config/teams")
    end
    
    # === Get team.
    # Get a team info.
    #
    # ==== Parameters
    # id:: (Integer) -- Team id.
    # options:: (Hash) -- List of Resource Collection Options shown above can be used as parameter.
    #
    # ==== Example
    #     @data = @mints_user.get_team(1)
    def get_team(id)
        return @client.raw("get", "/config/teams/#{id}")
    end

    # === Create team.
    # Create a team with data.
    #
    # ==== Parameters
    # data:: (Hash) -- Data to be submitted.
    #
    # ==== Example
    #     data = {
    #       "title": "New Team",
    #       "team_type_enum": 1
    #     }
    #     @data = @mints_user.create_team(data)
    def create_team(data)
        return @client.raw("post", "/config/teams", nil, data_transform(data))
    end
    
    # === Update team.
    # Update a team info.
    #
    # ==== Parameters
    # id:: (Integer) -- Team id.
    # data:: (Hash) -- Data to be submitted.
    #
    # ==== Example
    #     data = {
    #       "title": "New Team Modified",
    #       "team_type_enum": 1,
    #       "members": []
    #     }
    #     @data = @mints_user.update_team(5, data)
    def update_team(id, data)
        return @client.raw("put", "/config/teams/#{id}", nil, data_transform(data))
    end
end