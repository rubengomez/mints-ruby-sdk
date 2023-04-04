# Mints::Contact::Config::Appointments

```ruby
mints_contact = Mints::Contact.new(mints_url, api_key, session_token)

mints_contact.get_appointments(options) #=> Return a collection of appointments.

mints_contact.get_appointment(id, options) #=> Return a single appointment.

mints_contact.create_appointment(data) #=> Create an appointment.

mints_contact.update_appointment(id, data) #=> Update an appointment.

mints_contact.scheduled_appointments(data) #=> Get a collection of appointments filtering by object_type, object_id and dates range.

mints_contact.attach_invitee(data) #=> Attach invitee to an appointment.

mints_contact.attach_follower(data) #=> Attach follower to an appointment.

mints_contact.detach_invitee(data) #=> Detach invitee from an appointment.

mints_contact.detach_follower(data) #=> Detach follower from an appointment.

mints_contact.sync_invitee(data) #=> Sync an invitee from an appointment.

mints_contact.sync_follower(data) #=> Sync an follower from an appointment.

```