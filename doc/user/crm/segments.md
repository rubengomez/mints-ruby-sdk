# Mints::User::Crm::Segments

```ruby
user = Mints::User.new(mints_url, api_key, session_token)

user.get_segments_support_data #=> Get segments support data.

user.get_segments_attributes(options) #=> Get segments attributes.

user.get_segment_group(group_id) #=> Get segment group.

user.duplicate_segment(id, data) #=> Duplicate a segment.

user.get_segments(options) #=> Get a collection of segments.

user.get_segment(id, options) #=> Get a segment info.

user.create_segment(data) #=> Create a segment.

user.update_segment(id, data) #=> Update a segment info.

user.delete_segment(id) #=> Delete a segment.
```