# Mints::User::Crm::Contacts

```ruby
user = Mints::User.new(mints_url, api_key, session_token)

user.get_contacts_support_data #=> Get contacts support data.

user.get_online_activity(id) #=> Get online activity of a contact.

user.get_contacts(options, use_post) #=> Get a collection of contacts.

user.get_contact(id, options) #=> Get a contact data.

user.create_contact(data, options) #=> Create a contact

user.update_contact(id, data, options) #=> Update contact data.

user.get_contact_deal(contact_id) #=> Get a collection of deals of a contact.

user.create_contact_deal(contact_id, data) #=> Create a contact deal

user.delete_contact_deal(contact_id, deal_id) #=> Delete a contact deal

user.get_contact_user(contact_id) #=> Get user data of a contact.

user.create_contact_user(contact_id, data) #=> Relate a contact with an user.

user.delete_contact_user(contact_id, id) #=> Delete a relationship between a contact and an user.

user.get_contact_segments(contact_id) #=> Get segments of a contact.

user.get_contact_submissions(contact_id) #=> Get submissions of a contact.

user.get_contact_tags(contact_id) #=> Get tags of a contact.

user.merge_contacts(id, data) #=> Merge contacts.

user.send_magic_links(data) #=> Send magic links to contacts.

user.delete_contacts(data) #=> Delete different contacts.
```