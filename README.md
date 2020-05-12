# Mints Ruby SDK

This is a library to connect apps built on ruby to Mints.Cloud

## Installation

Add gem to the Gemfile
```bash
gem 'mints'
```

## Usage
Using Mints Public API
```ruby
pub = Mints::Pub.new(mints_url, api_key)
pub.get_stories
```

Using Mints Contact API
```ruby
con = Mints::Contact.new(mints_url, api_key)
con.login(email, password)
con.me
```

Using Mints User API
```ruby
con = Mints::User.new(mints_url, api_key)
con.login(email, password)
con.get_contacts
```
## Contact tracking usage
Your app controller need to be inherited from Mints::BaseController
```ruby
# application_controller.rb

class ApplicationController < Mints::BaseController
end
```
This controller will make the following class variables available:

| Variable        | Description                                   |
|   ---           |    :---:                                      |
| @mints_pub      | An already instanced public client            |
| @contact_token  | A token used by mints to identify the contact |
| @visit_id       | An identifier of the visit registered         |