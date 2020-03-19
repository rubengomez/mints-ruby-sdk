# Mints Ruby SDK

This is a library to connect apps built on ruby to Mints.Cloud

## Installation

Install using `gem` command
```bash
gem install mints
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
