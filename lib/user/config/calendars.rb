module Calendars
    ##
    # == Calendars
    #

    # === Get calendars.
    # Get a collection of calendars.
    #
    # ==== Parameters
    # options:: (Hash) -- List of Resource Collection Options shown above can be used as parameter.
    #
    # ==== First Example
    #     @data = @mints_user.get_calendars
    #
    # ==== Second Example
    #     options = {
    #       "fields": "title"
    #     }
    #     @data = @mints_user.get_calendars(options)
    def get_calendars(options = nil)
        @client.raw("get", "/config/calendars", options)
    end
    
    # === Get calendar.
    # Get a calendar info.
    #
    # ==== Parameters
    # id:: (Integer) -- Calendar id.
    # options:: (Hash) -- List of Resource Collection Options shown above can be used as parameter.
    #
    # ==== First Example
    #     @data = @mints_user.get_calendar(1)
    #
    # ==== Second Example
    #     options = {
    #       "fields": "title"
    #     }
    #     @data = @mints_user.get_calendar(1, options)
    def get_calendar(id, options = nil)
        @client.raw("get", "/config/calendars/#{id}", options)
    end
    
    # === Create calendar.
    # Create a calendar with data.
    #
    # ==== Parameters
    # data:: (Hash) -- Data to be submitted.
    #
    # ==== Example
    #     data = { 
    #       "title": "New Calendar",
    #       "object_type": "contacts",
    #       "object_id": 1
    #     }
    #     @data = @mints_user.create_calendar(data)
    def create_calendar(data)
        @client.raw("post", "/config/calendars", nil, data_transform(data))
    end

    # === Update calendar.
    # Update a calendar info.
    #
    # ==== Parameters
    # id:: (Integer) -- Calendar id.
    # data:: (Hash) -- Data to be submitted.
    #
    # ==== Example
    #     data = { 
    #       "title": "New Calendar Modified",
    #       "object_type": "contacts",
    #       "object_id": 1
    #     }
    #     @data = @mints_user.update_calendar(4, data)
    def update_calendar(id, data)
        @client.raw("put", "/config/calendars/#{id}", nil, data_transform(data))
    end
    
    # === Delete calendar.
    # Delete a calendar.
    #
    # ==== Parameters
    # id:: (Integer) -- Calendar id.
    #
    # ==== Example
    #     @data = @mints_user.delete_calendar(4)
    def delete_calendar(id)
        @client.raw("delete", "/config/calendars/#{id}")
    end
end