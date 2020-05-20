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
## Generate mints files
This command will generate the mints_config.yml file, API controlles and routes to have available the mints endpoints
```bash
rails generate mints_files
```
## Contact tracking usage
Your app controller needs to be inherited from Mints::BaseController
```ruby
# application_controller.rb

class ApplicationController < Mints::BaseController
end
```
This heritance will make the following class variables available:

| Variable        | Description                                                                          |
|   ---           |    :---:                                                                             |
| @host           | Host defined in mints_config.yml file                                                |
| @api_key        | API key defined in mints_config.yml file                                             |
| @mints_pub      | An already instanced public client                                                   |
| @contact_token  | A token used by mints to identify the contact                                        |
| @visit_id       | An identifier of the visit registered                                                |
| @mints_contact  | An already instanced contact client (not usable until call the contact login method) |

And the following controller methods:
| Method                    | Parameters     | Return value | Description                                    |
|   ---                     |   :---:        |   :---:      | :---:                                          |
| mints_contact_signed_in?  | none           | boolean      | Indicates if the contact has an active session |
| mints_contact_login       | email, password| void         | Starts a contact session                       |
| mints_contact_logout      | none           | void         | Ends a contact session                         |

## Admin controller usage
If want to have a private section where only a mints user can acces and use the private user api is needed to inherit from the AdminBaseController.

```ruby
# admin_controller.rb

class AdminController < Mints::AdminBaseController
end
```

This heritance will make the following class variables available:
| Variable        | Description                                                                          |
|   ---           |    :---:                                                                             |
| @host           | Host defined in mints_config.yml file                                                |
| @api_key        | API key defined in mints_config.yml file                                             |
| @mints_user     | An already instanced user client  (not usable until call the user login method)      |

And the following controller methods:
| Method                    | Parameters     | Return value | Description                                 |
|   ---                     |   :---:        |   :---:      | :---:                                       |
| mints_user_login          | email, password| void         | Starts a user session                       |
| mints_user_logout         | none           | void         | Ends a user session                         |