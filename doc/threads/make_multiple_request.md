# Mints::Threads

```ruby
# Threads can be applied for every kind of mints instance (public, contact and user)

mints_pub = Mints::Pub.new('your_mints_url', 'your_api_key')

version_options = {
  # your options here...
}

stories_options = {
  # your options here...
}

locations_options = {
  # your options here...
}

# Examples for different ways to attach data for every request
cxf_calls = [
  # The first example i attach all possible options to give, no matter if the option as nil value
  { action: 'get', url: '/content/content-pages/mail-content', options: version_options, data: nil, base_url: nil, compatibility_options: {}, only_tracking: false },
  # The second example i attach only the options i recognize and send as object instead of hash
  { 'action' => 'get', 'url' => '/content/content-pages/home', 'options' => version_options },
  # The following examples are array (only to prove that can be attached as array)
  ['get', '/ecommerce/product-versions', version_options],
  %w[get /ecommerce/my-shopping-cart],
  ['get', '/content/story-versions', stories_options],
  # The last example proves the first parameter can be the name of the function (this applies to hash, array, etc.)
  ['get_locations', locations_options, true],
  { action: 'get_locations', url: locations_options, use_post: true },
]

all_payloads = mints_pub.make_multiple_request(cxf_calls)
# OR
payload_1, payload_2, payload_3, payload_4, payload_5, payload_6, payload_7 = mints_pub.make_multiple_request(cxf_calls)

```