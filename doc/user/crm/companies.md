# Mints::User::Crm::Companies

```ruby
user = Mints::User.new(mints_url, api_key, session_token)

user.get_companies_support_data #=> Get support data of companies.

user.get_companies(options, use_post) #=> Get a collection of companies.

user.get_company(id, options) #=> Get a company info.

user.create_company(data, options) #=> Create a company.

user.update_company(id, data, options) #=> Update a company info.

user.delete_companies(data) #=> Delete a group of companies.
```