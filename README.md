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
mints_pub = Mints::Pub.new(mints_url, api_key)
mints_pub.get_stories
```

Using Mints Contact API

```ruby
mints_contact = Mints::Contact.new(mints_url, api_key)
mints_contact.login(email, password)
mints_contact.me
```

Using Mints User API

```ruby
mints_user = Mints::User.new(mints_url, api_key)
mints_user.login(email, password)
mints_user.get_contacts
```

Using Mints User API by Service account

```ruby
# Usually the api_key and the session token are the same, you can go to the service accounts section
# from your CXF instance and generate your service account api key  
mints_service_account = Mints::User.new(mints_url, api_key, api_key)
mints_service_account.get_contacts
```

## Generate mints files

This command will generate the mints_config.yml.erb file, API controlles and routes to have available the mints
endpoints

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

| Variable       |                                     Description                                      |
|----------------|:------------------------------------------------------------------------------------:|
| @host          |                      Host defined in mints_config.yml.erb file                       |
| @api_key       |                     API key defined in mints_config.yml.erb file                     |
| @mints_pub     |                          An already instanced public client                          |
| @contact_token |                    A token used by mints to identify the contact                     |
| @visit_id      |                        An identifier of the visit registered                         |
| @mints_contact | An already instanced contact client (not usable until call the contact login method) |

And the following controller methods:

| Method                         |       Parameters        | Return value |                           Description                            |
|--------------------------------|:-----------------------:|:------------:|:----------------------------------------------------------------:|
| mints_contact_signed_in?       |          none           |   boolean    |          Indicates if the contact has an active session          |
| mints_contact_login            |     email, password     |     void     |                     Starts a contact session                     |
| mints_contact_logout           |          none           |     void     |                      Ends a contact session                      |
| mints_contact_magic_link_login | hash, redirect_in_error |     void     | Starts a contact session in mints.cloud and set a session cookie |

## Admin controller usage

If want to have a private section where only a mints user can acces and use the private user api is needed to inherit
from the AdminBaseController.

```ruby
# admin_controller.rb

class AdminController < Mints::AdminBaseController
end
```

This heritance will make the following class variables available:

| Variable               |                                   Description                                   |
|------------------------|:-------------------------------------------------------------------------------:|
| @host                  |                    Host defined in mints_config.yml.erb file                    |
| @api_key               |                  API key defined in mints_config.yml.erb file                   |
| @mints_user            | An already instanced user client  (not usable until call the user login method) |
| @mints_service_account |                   An already instanced service_account client                   |

And the following controller methods:

| Method                      |   Parameters    | Return value |                          Description                          |
|-----------------------------|:---------------:|:------------:|:-------------------------------------------------------------:|
| mints_user_login            | email, password |     void     |                     Starts a user session                     |
| mints_user_logout           |      none       |     void     |                      Ends a user session                      |
| mints_user_signed_in?       |      none       |   Boolean    |          Indicates if the user has an active session          |
| mints_user_magic_link_login |      hash       |     void     | Starts a user session in mints.cloud and set a session cookie |

## Mints config file

The mints.config.yml file allows to set the CXF instance to which the implementation will access, it can add the host,
api key for CXF, in addition to setting the cache rules with redis, if you want to add a url to cache , you should add
it to the groups array and set the cache time.

```yaml
  # Mints connection configuration
  mints:
    host: http://your_host_goes_here.com
    api_key: your_mints_api_key_goes_here
    mints_slug: slug_id #save id and token in redis
  redis_cache:
    use_cache: boolean_value_to_enable_and_disable_cache
    redis_host: your_redis_server_host
    redis_port: your_redis_server_port
    redis_db: your_redis_database
    groups:
      - urls:
          - group_of_urls
        time: time_that_will_be_applied_to_urls_in_seconds
```

To enable sdk debugging you can change the variable debug.
Finally, to configure the sharing of cookies between domains, you can configure the "iframe cookies", where you
establish how long the cookie will have, if it is activated and the domains to share cookies (to have this
functionality, we recommend the use of the template).

```yaml
  # Mints connection configuration
  sdk:
    debug: false
  cookies_iframe:
    activated: boolean_value_to_enable_and_disable_cookies_iframe
    expire_time: expire_time_of_cookies_iframe_in_hours
    hosts:
      - array_of_host_to_send_cookies
```

## Override default clients

If you want other clients for admin/base controller, you need to specify them with the "define_mints_clients" method
Example:

```ruby
# admin_controller.rb

class AdminController < Mints::AdminBaseController
  def define_mints_clients
    %w[contact user pub service_account]
  end
end
```

## Error catching

The SDK provides different errors that are identified according to the response provided by CXF,
the errors can be 404, 401, 422, 500, etc.
To rescue these errors, it is done as follows:

```ruby

# Example 1
begin
  @mints_pub.client.raw('/invalid-url')
rescue => Mints::Errors::ResourceNotFoundException
  puts "Error 404"
end

# Example 2

begin
  response = @mints_contact.register(data)
rescue Mints::Errors::ValidationException => e
  response = e.to_h
  # This will return a Hash with the information needed to debug
  # Example:
  {
    :client => sdk_instance,
    # Client instance
    # @host = "https://your_cxf_instance",
    # @api_key = current_api_key,
    # @session_token = current_session_token,
    # @contact_token_id = current_contact_token_id,
    # @visit_id = current_visit_id,
    # @debug = current_debug_flag,
    # @scope = current_scope,
    # @base_url = current_base_url
    :title => "Request failed with status 422",
    :detail => "Unprocessable Entity",
    :http_status => 422,
    :response => { "email" => ["The email has already been taken."] },
    :errors => ["The email has already been taken."]
  }
end

```

The current errors are:

| Error                     | Status |             Full error name              |
|---------------------------|:------:|:----------------------------------------:|
| AccessDeniedException     |  401   |   Mints::Errors::AccessDeniedException   |
| ResourceNotFoundException |  404   | Mints::Errors::ResourceNotFoundException |
| MethodNotAllowedException |  405   | Mints::Errors::MethodNotAllowedException |
| ValidationException       |  422   |    Mints::Errors::ValidationException    |
| InternalServerException   |  500   |  Mints::Errors::InternalServerException  |

<details>
  <summary> Mints::Pub </summary>

- Mints::Pub::Config
  - [Mints::Pub::Config::Attributes](doc/pub/config/attributes.md)
  - [Mints::Pub::Config::PublicFolders](doc/pub/config/public_folders.md)
  - [Mints::Pub::Config::Tags](doc/pub/config/tags.md)
  - [Mints::Pub::Config::Taxonomies](doc/pub/config/taxonomies.md)


- Mints::Pub::Content
  - [Mints::Pub::Content::Assets](doc/pub/content/assets.md)
  - [Mints::Pub::Content::ContentBundles](doc/pub/content/content_bundles.md)
  - [Mints::Pub::Content::ContentInstanceVersions](doc/pub/content/content_instance_versions.md)
  - [Mints::Pub::Content::ContentInstances](doc/pub/content/content_instances.md)
  - [Mints::Pub::Content::Forms](doc/pub/content/forms.md)
  - [Mints::Pub::Content::Stories](doc/pub/content/stories.md)
  - [Mints::Pub::Content::StoryVersions](doc/pub/content/story_versions.md)

- Mints::Pub::Ecommerce
  - [Mints::Pub::Ecommerce::Locations](doc/pub/ecommerce/locations.md)
  - [Mints::Pub::Ecommerce::Orders](doc/pub/ecommerce/orders.md)
  - [Mints::Pub::Ecommerce::Products](doc/pub/ecommerce/products.md)

</details>

<details>
  <summary> Mints::Contact </summary>

- Mints::Contact::Config
  - [Mints::Contact::Config::Appointments](doc/contact/config/appointments.md)


- Mints::Contact::Content
  - [Mints::Contact::Content::Conversations](doc/contact/content/conversations.md)

- Mints::Contact::Ecommerce
  - [Mints::Contact::Ecommerce::OrderItemGroups](doc/contact/ecommerce/order_item_groups.md)
  - [Mints::Contact::Ecommerce::OrderItems](doc/contact/ecommerce/order_items.md)
  - [Mints::Contact::Ecommerce::Orders](doc/contact/ecommerce/orders.md)
  - [Mints::Contact::Ecommerce::Vouchers](doc/contact/ecommerce/vouchers.md)

</details>

<details>
  <summary> Mints::User </summary>

- Mints::User::Config
  - [Mints::User::Config::ApiKey](doc/user/config/api_key.md)
  - [Mints::User::Config::Appointments](doc/user/config/appointments.md)
  - [Mints::User::Config::AttributeGroups](doc/user/config/attribute_groups.md)
  - [Mints::User::Config::Attributes](doc/user/config/attributes.md)
  - [Mints::User::Config::Calendar](doc/user/config/calendar.md)
  - [Mints::User::Config::PublicFolder](doc/user/config/public_folders.md)
  - [Mints::User::Config::Relationships](doc/user/config/relationships.md)
  - [Mints::User::Config::Roles](doc/user/config/roles.md)
  - [Mints::User::Config::Seeds](doc/user/config/seeds.md)
  - [Mints::User::Config::SystemSettings](doc/user/config/system_settings.md)
  - [Mints::User::Config::Tags](doc/user/config/tags.md)
  - [Mints::User::Config::Taxonomies](doc/user/config/taxonomies.md)
  - [Mints::User::Config::Teams](doc/user/config/teams.md)
  - [Mints::User::Config::Users](doc/user/config/users.md)

- [Mints::User::Contacts](doc/user/contacts/contacts.md)

- [Mints::User::Content](doc/user/content/content.md)
  - [Mints::User::Content::Assets](doc/user/content/assets.md)
  - [Mints::User::Content::ContentInstances](doc/user/content/content_instances.md)
  - [Mints::User::Content::ContentTemplates](doc/user/content/content_templates.md)
  - [Mints::User::Content::Conversations](doc/user/content/conversations.md)
  - [Mints::User::Content::Dam](doc/user/content/dam.md)
  - [Mints::User::Content::Forms](doc/user/content/forms.md)
  - [Mints::User::Content::MessageTemplates](doc/user/content/message_templates.md)
  - [Mints::User::Content::Messages](doc/user/content/messages.md)
  - [Mints::User::Content::Pages](doc/user/content/pages.md)
  - [Mints::User::Content::Stories](doc/user/content/stories.md)
  - [Mints::User::Content::StoryTemplates](doc/user/content/story_templates.md)
  - [Mints::User::Content::StoryVersions](doc/user/content/story_versions.md)

- Mints::User::Crm
  - [Mints::User::Crm::Companies](doc/user/crm/companies.md)
  - [Mints::User::Crm::Contacts](doc/user/crm/contacts.md)
  - [Mints::User::Crm::Deals](doc/user/crm/deals.md)
  - [Mints::User::Crm::Favorites](doc/user/crm/favorites.md)
  - [Mints::User::Crm::Segments](doc/user/crm/segments.md)
  - [Mints::User::Crm::Users](doc/user/crm/users.md)
  - [Mints::User::Crm::WorkflowStepObjects](doc/user/crm/workflow_step_objects.md)
  - [Mints::User::Crm::WorkflowSteps](doc/user/crm/workflow_steps.md)
  - [Mints::User::Crm::Workflows](doc/user/crm/workflows.md)

- Mints::User::Ecommerce
  - [Mints::User::Ecommerce::ItemPrices](doc/user/ecommerce/item_prices.md)
  - [Mints::User::Ecommerce::Locations](doc/user/ecommerce/locations.md)
  - [Mints::User::Ecommerce::OrderItemGroups](doc/user/ecommerce/order_item_groups.md)
  - [Mints::User::Ecommerce::OrderStatuses](doc/user/ecommerce/order_statuses.md)

  - [Mints::User::Ecommerce::Orders](doc/user/ecommerce/orders.md)
  - [Mints::User::Ecommerce::PriceList](doc/user/ecommerce/price_list.md)
  - [Mints::User::Ecommerce::ProductTemplates](doc/user/ecommerce/product_templates.md)
  - [Mints::User::Ecommerce::ProductVariations](doc/user/ecommerce/product_variations.md)
  - [Mints::User::Ecommerce::Products](doc/user/ecommerce/products.md)
  - [Mints::User::Ecommerce::Skus](doc/user/ecommerce/skus.md)
  - [Mints::User::Ecommerce::Taxes](doc/user/ecommerce/taxes.md)
  - [Mints::User::Ecommerce::VariantOptions](doc/user/ecommerce/variant_options.md)
  - [Mints::User::Ecommerce::VariantValues](doc/user/ecommerce/variant_values.md)
  - [Mints::User::Ecommerce::Vouchers](doc/user/ecommerce/vouchers.md)

- [Mints::User::Helpers](doc/user/helpers/helpers.md)
  - [Mints::User::Helpers::ObjectActivities](doc/user/helpers/object_activities.md)
  - [Mints::User::Helpers::ObjectFolders](doc/user/helpers/object_folders.md)
  - [Mints::User::Helpers::UserFolders](doc/user/helpers/user_folders.md)

- [Mints::User::Marketing](doc/user/marketing/marketing.md)

- [Mints::User::Profile](doc/user/profile/profile.md)

</details>

