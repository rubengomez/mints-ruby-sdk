# Mints::User::Crm::Deals

```ruby
user = Mints::User.new(mints_url, api_key, session_token)

user.get_deal_permits(id) #=> Get permits of a deal.

user.get_deal_support_data #=> Get support data of deals.

user.get_deal_currencies #=> Get currencies of deals.

user.get_deals(options, use_post) #=> Get a collection of deals.

user.get_deal(id, options) #=> Get a deal info.

user.create_deal(data, options) #=> Create a deal

user.update_deal(id, data, options) #=> Update a deal data.
```