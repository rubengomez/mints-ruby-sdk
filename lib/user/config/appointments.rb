module Appointments
    ##
    # == Appointments
    #

    # === Get appointments.
    # Get a collection of appointments.
    #
    # ==== Parameters
    # options:: (Hash) -- List of Resource Collection Options shown above can be used as parameter.
    #
    # ==== First Example
    #     @data = @mints_user.get_appointments
    #
    # ==== Second Example
    #     options = {
    #       "fields": "id"
    #     }
    #     @data = @mints_user.get_appointments(options)
    def get_appointments(options = nil)
        return @client.raw("get", "/config/appointments", options)
    end
    
    # === Get appointment.
    # Get an appointment info.
    #
    # ==== Parameters
    # id:: (Integer) -- Appointment id.
    # options:: (Hash) -- List of Resource Collection Options shown above can be used as parameter.
    #
    # ==== First Example
    #     @data = @mints_user.get_appointment(1)
    #
    # ==== Second Example
    #     options = {
    #       "fields": "id"
    #     }
    #     @data = @mints_user.get_appointment(1, options)
    def get_appointment(id, options = nil)
        return @client.raw("get", "/config/appointments/#{id}", options)
    end
    
    # === Create appointment.
    # Create an appointment with data.
    #
    # ==== Parameters
    # data:: (Hash) -- Data to be submitted.
    #
    # ==== Example
    #     data = {
    #       "object_type": "contacts",
    #       "object_id": 1,
    #       "title": "New Appointment",
    #       "start": "2021-09-06T20:29:16+00:00",
    #       "end": "2022-09-06T20:29:16+00:00",
    #       "attendee_id": 1
    #     }
    #     @data = @mints_user.create_appointment(data)
    def create_appointment(data)
        return @client.raw("post", "/config/appointments", nil, data_transform(data))
    end

    # === Update appointment.
    # Update an appointment info.
    #
    # ==== Parameters
    # id:: (Integer) -- Appointment id.
    # data:: (Hash) -- Data to be submitted.
    #
    # ==== Example
    #     data = {
    #       "object_id": 2
    #     }
    #     @data = @mints_user.update_appointment(1, data)
    def update_appointment(id, data)
        return @client.raw("put", "/config/appointments/#{id}", nil, data_transform(data))
    end
    
    # === Delete appointment.
    # Delete an appointment.
    #
    # ==== Parameters
    # id:: (Integer) -- Appointment id.
    #
    # ==== Example
    #     @data = @mints_user.delete_appointment(1)
    def delete_appointment(id)
        return @client.raw("delete", "/config/appointments/#{id}")
    end

    # === Scheduled appointments.
    # Schedule an appointment.
    #
    # ==== Parameters
    # data:: (Hash) -- Data to be submitted.
    #
    # ==== Example
    #     data = {
    #       "object_type": "contacts",
    #       "object_id": 1,
    #       "start": "2021-09-06T20:29:16+00:00",
    #       "end": "2022-09-06T20:29:16+00:00"
    #     }
    #     @data = @mints_user.scheduled_appointments(data)
    def scheduled_appointments(data)
        return @client.raw("post", "/config/appointments/scheduled-appointments", nil, data_transform(data))
    end
    
    # === Reschedule appointment.
    # Reschedule an appointment.
    #
    # ==== Parameters
    # data:: (Hash) -- Data to be submitted.
    #
    # ==== Example
    #     data = {
    #       "appointment_id": 2,
    #       "start": "2021-09-06T20:29:16+00:00",
    #       "end": "2022-09-06T20:29:16+00:00"
    #     }
    #     @data = @mints_user.reschedule_appointment(data)
    def reschedule_appointment(data)
        return @client.raw("post", "/config/appointments/reschedule-appointment", nil, data_transform(data))
    end
    
    # === Attach invitee.
    # Attach invitee.
    #
    # ==== Parameters
    # data:: (Hash) -- Data to be submitted.
    #
    # ==== Example
    #     data = {
    #       "appointment_id": 2,
    #       "invitee_ids": [ 2 ]
    #     }
    #     @data = @mints_user.attach_invitee(data)
    def attach_invitee(data)
        return @client.raw("post", "/config/appointments/attach-invitee", nil, data_transform(data))
    end

    # === Attach follower.
    # Attach follower.
    #
    # ==== Parameters
    # data:: (Hash) -- Data to be submitted.
    #
    # ==== Example
    #     data = {
    #       "appointment_id": 2,
    #       "follower_ids": [ 2 ]
    #     }
    #     @data = @mints_user.attach_follower(data)
    def attach_follower(data)
        return @client.raw("post", "/config/appointments/attach-follower", nil, data_transform(data))
    end
    
    # === Detach invitee.
    # Detach invitee.
    #
    # ==== Parameters
    # data:: (Hash) -- Data to be submitted.
    #
    # ==== Example
    #     data = {
    #       "appointment_id": 2,
    #       "invitee_ids": [ 2 ]
    #     }
    #     @data = @mints_user.detach_invitee(data)
    def detach_invitee(data)
        return @client.raw("post", "/config/appointments/detach-invitee", nil, data_transform(data))
    end

    # === Detach follower.
    # Detach follower.
    #
    # ==== Parameters
    # data:: (Hash) -- Data to be submitted.
    #
    # ==== Example
    #     data = {
    #       "appointment_id": 2,
    #       "follower_ids": [ 2 ]
    #     }
    #     @data = @mints_user.detach_follower(data)
    def detach_follower(data)
        return @client.raw("post", "/config/appointments/detach-follower", nil, data_transform(data))
    end
    
    # === Sync invitee.
    # Sync invitee.
    #
    # ==== Parameters
    # data:: (Hash) -- Data to be submitted.
    #
    # ==== Example
    #     data = {
    #       "appointment_id": 2,
    #       "invitee_ids": [ 2 ]
    #     }
    #     @data = @mints_user.sync_invitee(data)
    def sync_invitee(data)
        return @client.raw("post", "/config/appointments/sync-invitee", nil, data_transform(data))
    end
    
    # === Sync follower.
    # Sync follower.
    #
    # ==== Parameters
    # data:: (Hash) -- Data to be submitted.
    #
    # ==== Example
    #     data = {
    #       "appointment_id": 2,
    #       "follower_ids": [ 2 ]
    #     }
    #     @data = @mints_user.sync_follower(data)
    def sync_follower(data)
        return @client.raw("post", "/config/appointments/sync-follower", nil, data_transform(data))
    end
end