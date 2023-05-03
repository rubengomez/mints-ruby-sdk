# frozen_string_literal: true

module ContactAppointments
  # Appointments

  ##
  # === Get Appointments.
  # Get a collection of appointments.
  #
  # ==== Parameters
  # options:: (Hash) -- List of Resource Collection Options shown above can be used as parameter.
  #
  # ==== First Example
  #     @data = @mints_contact.get_appointments
  #
  # ==== Second Example
  #     options = {
  #       fields: 'id, created_at'
  #     }
  #     @data = @mints_contact.get_appointments(options)
  def get_appointments(options = nil)
    @client.raw('get', '/contacts/appointments', options)
  end

  ##
  # === Get Appointment.
  # Get an appointment info.
  #
  # ==== Parameters
  # options:: (Hash) -- List of Resource Collection Options shown above can be used as parameter.
  #
  # ==== First Example
  #     @data = @mints_contact.get_appointment(1)
  #
  # ==== Second Example
  #     options = {
  #       fields: 'id, created_at'
  #     }
  #     @data = @mints_contact.get_appointment(1, options)
  def get_appointment(id, options = nil)
    @client.raw('get', "/contacts/appointments/#{id}", options)
  end

  ##
  # === Create Appointment.
  # Create an appointment with data.
  #
  # ==== Parameters
  # data:: (Hash) -- Data to be submitted.
  #
  # ==== Example
  #     data = {
  #       object_model: 'products',
  #       object_id: 1,
  #       title: 'New Appointment',
  #       start: '2021-11-25T14:15:00+00:00',
  #       end: '2022-01-01T13:00:00+00:00'
  #     }
  #     @data = @mints_contact.create_appointment(data)
  def create_appointment(data)
    @client.raw('post', '/contacts/appointments', nil, data_transform(data))
  end

  ##
  # === Update Appointment.
  # Update an appointment info.
  #
  # ==== Parameters
  # id:: (Integer) -- Appointment id.
  # data:: (Hash) -- Data to be submitted.
  #
  # ==== Example
  #     data = {
  #       object_id: 2
  #     }
  #     @data = @mints_contact.update_appointment(1, data)
  def update_appointment(id, data)
    @client.raw('put', "/contacts/appointments/#{id}", nil, data_transform(data))
  end

  ##
  # === Scheduled Appointments.
  # Get a collection of appointments filtering by object_type, object_id and dates range.
  #
  # ==== Parameters
  # data:: (Hash) -- Data to be submitted.
  #
  # ==== Example
  #     data = {
  #       object_model: 'products',
  #       object_id: 2,
  #       start: '2021-11-25T14:15:00+00:00',
  #       end: '2022-01-01T13:00:00+00:00'
  #     }
  #     @data = @mints_contact.scheduled_appointments(data)
  def scheduled_appointments(data)
    @client.raw('post', '/contacts/appointments/scheduled-appointments', nil, data_transform(data))
  end

  ##
  # === Attach Invitee.
  # Attach invitee to an appointment.
  #
  # ==== Parameters
  # data:: (Hash) -- Data to be submitted.
  #
  # ==== Example
  #     data = {
  #       appointment_id: 1,
  #       invitee_ids: 1
  #     }
  #     @data = @mints_contact.attach_invitee(data)
  def attach_invitee(data)
    @client.raw('post', '/contacts/appointments/attach-invitee', nil, data_transform(data))
  end

  ##
  # === Attach Follower.
  # Attach follower to an appointment.
  #
  # ==== Parameters
  # data:: (Hash) -- Data to be submitted.
  #
  # ==== Example
  #     data = {
  #       appointment_id: 1,
  #       follower_ids: 1
  #     }
  #     @data = @mints_contact.attach_follower(data)
  def attach_follower(data)
    @client.raw('post', '/contacts/appointments/attach-follower', nil, data_transform(data))
  end

  ##
  # === Detach Invitee.
  # Detach invitee from an appointment.
  #
  # ==== Parameters
  # data:: (Hash) -- Data to be submitted.
  #
  # ==== Example
  #     data = {
  #       appointment_id: 1,
  #       invitee_ids: 1
  #     }
  #     @data = @mints_contact.detach_invitee(data)
  def detach_invitee(data)
    @client.raw('post', '/contacts/appointments/detach-invitee', nil, data_transform(data))
  end

  ##
  # === Detach Follower.
  # Detach follower from an appointment.
  #
  # ==== Parameters
  # data:: (Hash) -- Data to be submitted.
  #
  # ==== Example
  #     data = {
  #       appointment_id: 1,
  #       follower_ids: 1
  #     }
  #     @data = @mints_contact.detach_follower(data)
  def detach_follower(data)
    @client.raw('post', '/contacts/appointments/detach-follower', nil, data_transform(data))
  end

  ##
  # === Sync Invitee.
  # Sync an invitee from an appointment.
  #
  # ==== Parameters
  # data:: (Hash) -- Data to be submitted.
  #
  # ==== Example
  #     data = {
  #       appointment_id: 1,
  #       invitee_ids: 1
  #     }
  #     @data = @mints_contact.sync_invitee(data)
  def sync_invitee(data)
    @client.raw('post', '/contacts/appointments/sync-invitee', nil, data_transform(data))
  end

  ##
  # === Sync Follower.
  # Sync a follower from an appointment.
  #
  # ==== Parameters
  # data:: (Hash) -- Data to be submitted.
  #
  # ==== Example
  #     data = {
  #       appointment_id: 1,
  #       follower_ids: 1
  #     }
  #     @data = @mints_contact.sync_follower(data)
  def sync_follower(data)
    @client.raw('post', '/contacts/appointments/sync-follower', nil, data_transform(data))
  end
end
