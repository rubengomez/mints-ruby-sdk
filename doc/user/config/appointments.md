# Mints::User::Config::Appointments

```ruby
user = Mints::User.new(mints_url, api_key, session_token)

user.get_appointments(options) #=> Return a collection of appointments.

user.get_appointment(id, options) #=> Return a single appointment.

user.create_appointment(data) #=> Create an appointment.

user.update_appointment(id, data) #=> Update an appointment.

user.delete_appointment(id, data) #=> Delete an appointment.

user.scheduled_appointments(data) #=> Schedule an appointment.

user.reschedule_appointment(data) #=> Reschedule an appointment.

user.attach_invitee(data) #=> Attach invitee to an appointment.

user.attach_follower(data) #=> Attach follower to an appointment.

user.detach_invitee(data) #=> Detach invitee from an appointment.

user.detach_follower(data) #=> Detach follower from an appointment.

user.sync_invitee(data) #=> Sync an invitee from an appointment.

user.sync_follower(data) #=> Sync an follower from an appointment.

```