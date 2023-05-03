# Mints::Pub::Content::Forms

```ruby
mints_pub = Mints::Pub.new(mints_url, api_key)

mints_pub.get_forms(options) #=> Return a collection of forms.

mints_pub.get_form('form-slug', options) #=> Return a single form.

mints_pub.submit_form(data) #=> Submit a form with filled data.
```