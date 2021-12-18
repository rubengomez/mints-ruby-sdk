require_relative "./client.rb"
require_relative "./mints_helper.rb"
include ActionController::Cookies
module Mints
  class Contact
    attr_reader :client
    ##
    # === Initialize.
    # Class constructor.
    #
    # ==== Parameters
    # host:: (String) -- It's the visitor IP.
    # api_key:: (String) -- Mints instance api key.
    # contact_token_id:: (Integer) --  Cookie 'mints_contact_id' value (mints_contact_token).
    #
    # ==== Return
    # Returns a Contact object
    def initialize(host, api_key, session_token = nil, contact_token_id = nil, debug = false)
      @contact_v1_url = '/api/contact/v1'
      @client = Mints::Client.new(host, api_key, "contact", session_token, contact_token_id, nil, debug)
    end

    ### V1/CONTACTS ###

    ##
    # === Register.
    # Register a contact.
    #
    # ==== Parameters
    # data:: (Hash) -- It's the register data.
    #
    # ==== Example
    #     data = {
    #       "email": "email@example.com",
    #       "given_name": "Given Name",
    #       "last_name": "Last Name",
    #       "password": "password"
    #     }
    #     @mints_contact.register(data);
    def register(data)
      return @client.raw("post", "/contacts/register", nil, data_transform(data))
    end

    ##
    # === Login.
    # Starts a contact session.
    #
    # ==== Parameters
    # email:: (String) -- The email that will be logged.
    # password:: (String) -- The password of the email.
    #
    # ==== Example
    #     @mints_contact.login("email@example.com", "password")
    def login(email, password)
      data = {
        email: email,
        password: password
      }
      response = @client.raw("post", "/contacts/login", nil, {data: data}.to_json)
      if response.key? "session_token"
        @client.session_token = response["session_token"]
      end
      return response
    end

    ##
    # === Recover Password.
    # Send a email that contains a token to a contact. That token will be used in reset_password to establish a new password. 
    #
    # ==== Parameters
    # data:: (Hash) -- It's a data key where will be hosted the destination email.
    #
    # ==== Example
    #     data = { "email": "email@example.com" }
    #     @mints_contact.recover_password(data)
    def recover_password(data)
      return @client.raw("post", "/contacts/recover-password", nil, data_transform(data))
    end

    ##
    # === Reset Password.
    # Reset password using a token. The token is obtained by recover_password method.
    #
    # ==== Parameters
    # data:: (Hash) -- It's a set of data which contains all the information to reset a contact password.
    #
    # ==== Example
    #     data = { 
    #       "email": "email@example.com", 
    #       "password": "password", 
    #       "password_confirmation": "password", 
    #       "token": "644aa3aa0831d782cc42e42b11aedea9a2234389af4f429a8d96651295ecfa09" 
    #     }
    #     @mints_contact.reset_password(data)
    def reset_password(data)
      return @client.raw("post", "/contacts/reset-password", nil, data_transform(data))
    end

    ##
    # === OAuth Login.
    # Login a contact using oauth.
    def oauth_login(data)
      return @client.raw("post", "/contacts/oauth-login", nil, data)
    end

    ##
    # === Magic Link Login.
    # Starts a contact session with a token received in the contact email. The token will be received by send_magic_link method.
    #
    # ==== Parameters
    # token:: (String) -- The email token that will be used to log in.
    #
    # ==== Example
    #     @mints_contact.magic_link_login(
    #       "d8618c6d-a165-41cb-b3ec-d053cbf30059:zm54HtRdfHED8dpILZpjyqjPIceiaXNLfOklqM92fveBS0nDtyPYBlI4CPlPe3zq"
    #     )
    def magic_link_login(token)
      response = @client.raw("get", "/contacts/magic-link-login/#{token}", nil, '/api/v1')
      if response.key? "session_token"
        @client.session_token = response["session_token"]
      end
      return response
    end

    ##
    # === Send Magic Link.
    # Send magic link to contact by email. That magic link will be used in magic_link_login method.
    #
    # ==== Parameters
    # email:: (String) -- Contact's email.
    # template_slug:: (String) -- Email template's slug to be used in the email.
    # redirectUrl:: (String) -- Url to be redirected in the implemented page.
    # lifeTime:: (Integer) -- Maximum time of use in minutes.
    # maxVisits:: (Integer) -- The maximum number of uses of a token.
    #
    # ==== First Example
    #     @mints_contact.send_magic_link("email@example.com", "template_slug")
    #
    # ==== Second Example
    #     @mints_contact.send_magic_link("email@example.com", "template_slug", "", 1440, 3)
    def send_magic_link(email, template_slug, redirectUrl = '', lifeTime = 1440, maxVisits = nil)
      data = {
        email: email,
        lifeTime: lifeTime,
        maxVisits: maxVisits,
        redirectUrl: redirectUrl,
        templateId: template_slug
      }
      response = @client.raw("post", "/contacts/magic-link", nil, { data: data }.to_json, '/api/v1')
      return response
    end

    ### CONTACT/V1 ###

    ##
    # === Me.
    # Get contact logged info.
    #
    # ==== Parameters
    # # options:: (Hash) -- List of {Resource collection Options}[#class-Mints::Pub-label-Resource+collections+options+] shown above can be used as parameter.
    #
    # ==== First Example
    #     @data = @mints_contact.me
    #
    # ==== Second Example
    #     options = { 
    #       "attributes": true,
    #       "taxonomies": true
    #     } 
    #     @data = @mints_contact.me(options)
    def me(options = nil)
      return @client.raw("get", "/me", options, nil, @contact_v1_url)
    end

    ##
    # === Status.
    # Get contact logged status.
    #
    # ==== Example
    #     @data = @mints_contact.status
    def status
      return @client.raw("get", "/status", nil, nil, @contact_v1_url)
    end

    ##
    # === Update.
    # Update logged contact attributes.
    #
    # ==== Parameters
    # data:: (Hash) -- It's the data to update with a session active.
    #
    # ==== Example
    #     data = {
    #       "given_name": "Given Name", 
    #       "last_name": "Last Name"
    #     }
    #     @data = @mints_contact.update(data)
    def update(data)
      return @client.raw("put", "/update", nil, data_transform(data), @contact_v1_url)
    end

    ##
    # === Logout.
    # Ends a contact session previously logged.
    #
    # ==== Example
    #     @data = @mints_contact.logout
    def logout
      response = @client.raw("post", "/logout", nil, nil, @contact_v1_url) if session_token?
      if response["success"]
        @client.session_token = nil
      end 
      return response
    end

    ##
    # === Change Password.
    # Change password without email. To change the password a contact must be logged.
    #
    # ==== Parameters
    # data:: (Hash) -- A new password allocated in a data key.
    #
    # ==== Example
    #     data = { "password": "new_password" }
    #     @data = @mints_contact.change_password(data)
    def change_password(data)
      return @client.raw("post", "/change-password", nil, data_transform(data), @contact_v1_url)
    end

    # Conversations

    ##
    # === Get Conversations.
    # Get a collection of conversations.
    #
    # ==== Parameters
    # options:: (Hash) -- List of Resource Collection Options shown above can be used as parameter.
    # FIXME: This method doesn't return data.
    def get_conversations(options = nil)
      return @client.raw("get", "/content/conversations", options, nil, @contact_v1_url)
    end

    ##
    # === Get Conversation.
    # Get a conversation info.
    #
    # ==== Parameters
    # id:: (Integer) -- Conversation id.
    # options:: (Hash) -- List of Resource Collection Options shown above can be used as parameter.
    # FIXME: This method doesn't return data.
    def get_conversation(id, options = nil)
      return @client.raw("get", "/content/conversations/#{id}", options, nil, @contact_v1_url)
    end

    ##
    # === Create Conversation.
    # Create a conversation with data.
    #
    # ==== Parameters
    # data:: (Hash) -- Data to be submited.
    #
    # ==== Example
    #     data = {
    #       "title": "New Conversation To Test"
    #     }
    #     @data = @mints_contact.create_conversation(data)
    def create_conversation(data)
      return @client.raw("post", "/content/conversations", nil, data_transform(data), @contact_v1_url)
    end

    ##
    # === Update Conversation.
    # Update a location template info.
    #
    # ==== Parameters
    # id:: (Integer) -- Conversation id.
    # data:: (Hash) -- Data to be submited.
    # FIXME: This method doesn't locate conversation id to be updated. 
    def update_conversation(id, data)
      return @client.raw("put", "/content/conversations/#{id}", nil, data_transform(data), @contact_v1_url)
    end

    ##
    # === Update Conversation Status.
    # Update a conversation status.
    #
    # ==== Parameters
    # id:: (Integer) -- Conversation id.
    # data:: (Hash) -- Data to be submited.
    # FIXME: This method doesn't locate conversation id to be updated. 
    def update_conversation_status(id, data)
      return @client.raw("put", "/content/conversations/#{id}/status", nil, data_transform(data), @contact_v1_url)
    end

    ##
    # === Get Conversation Participants.
    # Update a conversation participants.
    #
    # ==== Parameters
    # id:: (Integer) -- Conversation id.
    # FIXME: This method doesn't locate conversation id to be updated. 
    def get_conversation_participants(id)
      #TODO: Test if this method needs data in options.
      return @client.raw("get", "/content/conversations/#{id}/participants", nil, nil, @contact_v1_url)
    end

    ##
    # === Get Messages.
    # Get a collection of messages.
    #
    # ==== Parameters
    # options:: (Hash) -- List of Resource Collection Options shown above can be used as parameter.
    # FIXME: This method doesn't return data.
    def get_messages(options = nil)
      return @client.raw("get", "/content/messages", options, nil, @contact_v1_url)
    end

    ##
    # === Get Message.
    # Get a message info.
    #
    # ==== Parameters
    # id:: (Integer) -- Message id.
    # options:: (Hash) -- List of Resource Collection Options shown above can be used as parameter.
    # FIXME: This method doesn't return data.
    def get_message(id, options = nil)
      return @client.raw("get", "/content/messages/#{id}", options, nil, @contact_v1_url)
    end

    ##
    # === Create Message.
    # Create a message with data.
    #
    # ==== Parameters
    # data:: (Hash) -- Data to be submited.
    #
    # ==== Example
    #     data = {
    #       "conversation_id": 3,
    #       "type": "text",
    #       "value": { 
    #         "text": "Message Text"
    #       }
    #     }
    #     @data = @mints_contact.create_message(data)
    def create_message(data)
      return @client.raw("post", "/content/messages", nil, data_transform(data), @contact_v1_url)
    end

    # Appointments

    ##
    # === Get Appointments.
    # Get a collection of appointments.
    #
    # ==== Parameters
    # options:: (Hash) -- List of Resource Collection Options shown above can be used as parameter.
    #
    # ==== First Example
    #     @data = @mints_contact.get_appointments
    #
    # ==== Second Example
    #     options = {
    #       "fields": "id, created_at"
    #     }
    #     @data = @mints_contact.get_appointments(options)
    def get_appointments(options = nil)
      return @client.raw("get", "/contacts/appointments", options)
    end

    ##
    # === Get Appointment.
    # Get an appointment info.
    #
    # ==== Parameters
    # options:: (Hash) -- List of Resource Collection Options shown above can be used as parameter.
    #
    # ==== First Example
    #     @data = @mints_contact.get_appointment(1)
    #
    # ==== Second Example
    #     options = {
    #       "fields": "id, created_at"
    #     }
    #     @data = @mints_contact.get_appointment(1, options)
    def get_appointment(id, options = nil)
      return @client.raw("get", "/contacts/appointments/#{id}", options)
    end

    ##
    # === Create Appointment.
    # Create an appointment with data.
    #
    # ==== Parameters
    # data:: (Hash) -- Data to be submited.
    #
    # ==== Example
    #     data = {
    #       "object_model": "products",
    #       "object_id": 1,
    #       "title": "New Appointment",
    #       "start": "2021-11-25T14:15:00+00:00",
    #       "end": "2022-01-01T13:00:00+00:00"
    #     }
    #     @data = @mints_contact.create_appointment(data)
    def create_appointment(data)
      return @client.raw("post", "/contacts/appointments", nil, data_transform(data))
    end

    ##
    # === Update Appointment.
    # Update an appointment info.
    #
    # ==== Parameters
    # id:: (Integer) -- Appointment id.
    # data:: (Hash) -- Data to be submited.
    #
    # ==== Example
    #     data = {
    #       "object_id": 2
    #     }
    #     @data = @mints_contact.update_appointment(1, data)
    def update_appointment(id, data)
      return @client.raw("put", "/contacts/appointments/#{id}", nil, data_transform(data))
    end

    ##
    # === Scheduled Appointments.
    # Get a collection of appointments filtering by object_type, object_id and dates range.
    #
    # ==== Parameters
    # data:: (Hash) -- Data to be submited.
    #
    # ==== Example
    #     data = {
    #       "object_model": "products",
    #       "object_id": 2,
    #       "start": "2021-11-25T14:15:00+00:00",
    #       "end": "2022-01-01T13:00:00+00:00"
    #     }
    #     @data = @mints_contact.scheduled_appointments(data)
    def scheduled_appointments(data)
      return @client.raw("post", "/contacts/appointments/scheduled-appointments", nil, data_transform(data))
    end

    ## 
    # === Attach Invitee.
    # Attach invitee to an appointment.
    #
    # ==== Parameters
    # data:: (Hash) -- Data to be submited.
    #
    # ==== Example
    #     data = {
    #       "appointment_id": 1,
    #       "invitee_ids": 1
    #     }
    #     @data = @mints_contact.attach_invitee(data)
    def attach_invitee(data)
      return @client.raw("post", "/contacts/appointments/attach-invitee", nil, data_transform(data))
    end

    ##
    # === Attach Follower.
    # Attach follower to an appointment.
    #
    # ==== Parameters
    # data:: (Hash) -- Data to be submited.
    #
    # ==== Example
    #     data = {
    #       "appointment_id": 1,
    #       "follower_ids": 1
    #     }
    #     @data = @mints_contact.attach_follower(data)
    def attach_follower(data)
      return @client.raw("post", "/contacts/appointments/attach-follower", nil, data_transform(data))
    end

    ##
    # === Detach Invitee.
    # Detach invitee from an appointment.
    #
    # ==== Parameters
    # data:: (Hash) -- Data to be submited.
    #
    # ==== Example
    #     data = {
    #       "appointment_id": 1,
    #       "invitee_ids": 1
    #     }
    #     @data = @mints_contact.detach_invitee(data)
    def detach_invitee(data)
      return @client.raw("post", "/contacts/appointments/detach-invitee", nil, data_transform(data))
    end

    ##
    # === Detach Follower.
    # Detach follower from an appointment.
    #
    # ==== Parameters
    # data:: (Hash) -- Data to be submited.
    #
    # ==== Example
    #     data = {
    #       "appointment_id": 1,
    #       "follower_ids": 1
    #     }
    #     @data = @mints_contact.detach_follower(data)
    def detach_follower(data)
      return @client.raw("post", "/contacts/appointments/detach-follower", nil, data_transform(data))
    end

    ##
    # === Sync Invitee.
    # Sync an invitee from an appointment.
    #
    # ==== Parameters
    # data:: (Hash) -- Data to be submited.
    #
    # ==== Example
    #     data = {
    #       "appointment_id": 1,
    #       "invitee_ids": 1
    #     }
    #     @data = @mints_contact.sync_invitee(data)
    def sync_invitee(data)
      return @client.raw("post", "/contacts/appointments/sync-invitee", nil, data_transform(data))
    end

    ##
    # === Sync Follower.
    # Sync a follower from an appointment.
    #
    # ==== Parameters
    # data:: (Hash) -- Data to be submited.
    #
    # ==== Example
    #     data = {
    #       "appointment_id": 1,
    #       "follower_ids": 1
    #     }
    #     @data = @mints_contact.sync_follower(data)
    def sync_follower(data)
      return @client.raw("post", "/contacts/appointments/sync-follower", nil, data_transform(data))
    end

    ##
    # === Get Orders.
    # Get a collection of orders.
    #
    # ==== Parameters
    # options:: (Hash) -- List of Resource Collection Options shown above can be used as parameter.
    # use_post:: (Boolean) -- Variable to determine if the request is by 'post' or 'get' functions.
    #
    # ==== First Example
    #     @data = @mints_pub.get_orders
    #
    # ==== Second Example
    #     options = { "fields": "title" }
    #     @data = @mints_pub.get_orders(options)
    #
    # ==== Third Example
    #     options = { "fields": "title" }
    #     @data = @mints_pub.get_orders(options, false)
    def get_orders(options = nil, use_post = true)
      if use_post
        return @client.raw("post", "/ecommerce/orders/query", options, nil, @contact_v1_url)
      else
        return @client.raw("get", "/ecommerce/orders", options, nil, @contact_v1_url)
      end
    end

    ##
    # === Get Order.
    # Get an order info.
    #
    # ==== Parameters
    # id:: (Integer) -- Order id.
    # options:: (Hash) -- List of Resource Collection Options shown above can be used as parameter.
    #
    # ==== First Example
    #     @data = @mints_pub.get_product(25)
    #
    # ==== Second Example
    #     options = {
    #       "fields": "title"
    #     }
    #     @data = @mints_pub.get_product(25, options)
    def get_order(id, options = nil)
      return @client.raw("get", "/ecommerce/orders/#{id}", options, nil, @contact_v1_url)
    end

    ##
    # === Create Order.
    # Create a order with data.
    #
    # ==== Parameters
    # data:: (Hash) -- Data to be submited.
    #
    # ==== Example
    #     data = {
    #       "order_template_id": 1,
    #       "order_status_id": 1,
    #       "sales_channel_id": 1
    #     }
    #     @data = @mints_pub.create_order(data)
    def create_order(data)
      return @client.raw("post", "/ecommerce/orders", nil, data_transform(data), @contact_v1_url)
    end

    ##
    # === Update Order.
    # Update an order info.
    #
    # ==== Parameters
    # id:: (Integer) -- Order Id
    # data:: (Hash) -- Data to be submited.
    # FIXME: This method doesnt update an order.
    def update_order(id, data)
      return @client.raw("put", "/ecommerce/orders/#{id}", nil, data_transform(data), @contact_v1_url)
    end

    #TODO: No tested
    # === Detach Order Item From Order Item Group.
    # Detach an order item from an order item group.
    #
    # ==== Parameters
    # orderItemId:: (Integer) -- Order item id.
    # groupId:: (Integer) -- Order items group id.
    #
    def detach_order_item_from_order_item_group(orderItemId, groupId)
      return @client.raw("put", "/ecommerce/order-items/detach/#{orderItemId}/order-items-groups/#{groupId}", nil, nil, @contact_v1_url)
    end

    #TODO: No tested
    # === Update Order Item From Order Item Group.
    # Update an order item data from an order item group.
    #
    # ==== Parameters
    # orderItemId:: (Integer) -- Order item id.
    # groupId:: (Integer) -- Order items group id.
    #
    def update_order_item_from_order_item_group(orderItemId, groupId, data)
      return @client.raw("put", "/ecommerce/order-items/update/#{orderItemId}/order-items-groups/#{groupId}", nil, data_transform(data), @contact_v1_url)
    end

    ##
    # === Get My Shopping Cart.
    # Get a collection of items in the shopping cart.
    #
    # ==== Example
    #     @data = @mints_contact.get_my_shopping_cart
    # FIXME: This method returns a nil data.
    def get_my_shopping_cart
      return @client.raw("get", "/ecommerce/my-shopping-cart", nil, nil, @contact_v1_url)
    end

    ##
    # === Add Item To Shopping Cart.
    # Add an item into a shopping cart.
    #
    # ==== Parameters
    # data:: (Hash) -- Data to be submited.
    #
    # ==== Example
    #     data = {
    #       "quantity": 1,
    #       "sku_id": 1,
    #       "price_list_id": 1
    #     }
    #     @data = @mints_contact.add_item_to_shopping_cart(data)
    def add_item_to_shopping_cart(data)
      return @client.raw("post", "/ecommerce/shopping-cart", nil, data_transform(data), @contact_v1_url)
    end

    ##
    # === Get Order Items.
    # Get a collection of order items.
    #TODO: Find a way to show order items.
    def get_order_items(options = nil)
      return @client.raw("get", "/ecommerce/order-items", options, nil, @contact_v1_url)
    end

    ##
    # === Get Order Item.
    # Get an order item info.
    #TODO: Find a way to show order items.
    def get_order_item(id, options = nil)
      return @client.raw("get", "/ecommerce/order-items/#{id}", options, nil, @contact_v1_url)
    end

    ##
    # === Get Order Item Groups.
    # Get a collection of order item groups.
    #
    # ==== Parameters
    # options:: (Hash) -- List of Resource Collection Options shown above can be used as parameter.
    #
    # ==== First Example
    #     @data = @mints_contact.get_order_item_groups
    #
    # ==== Second Example
    #     options = {
    #       "fields": "id"
    #     }
    #     @data = @mints_contact.get_order_item_groups(options)
    def get_order_item_groups(options = nil)
      return @client.raw("get", "/ecommerce/order-items-groups", options, nil, @contact_v1_url)
    end

    ##
    # === Get Order Item Group.
    # Get an order item group info.
    #
    # ==== Parameters
    # id:: (Integer) -- Order Item Group Id.
    # options:: (Hash) -- List of Resource Collection Options shown above can be used as parameter.
    #
    # ==== First Example
    #     @data = @mints_contact.get_order_item_group(130)
    #
    # ==== Second Example
    #     options = {
    #       "fields": "id"
    #     }
    #     @data = @mints_contact.get_order_item_group(130, options)
    def get_order_item_group(id, options = nil)
      return @client.raw("get", "/ecommerce/order-items-groups/#{id}", options, nil, @contact_v1_url)
    end

    ##
    # === Create Order Item Group.
    # Create an order item group with data if you are related to that order.
    #
    # ==== Parameters
    # data:: (Hash) -- Data to be submited.
    #
    # ==== First Example
    #     data = {
    #       "name": "New Order Item Group",
    #       "quantity": 1,
    #       "order_id": 1,
    #       "on_sale_price": 100
    #     }
    #     @data = @mints_contact.create_order_item_group(data)
    #
    # ==== Second Example
    #     data = {
    #       "name": "",
    #       "quantity": 1,
    #       "order_id": 1,
    #       "sku_id": 1
    #     }
    #     @data = @mints_contact.create_order_item_group(data)
    def create_order_item_group(data)
      return @client.raw("post", "/ecommerce/order-items-groups", nil, data_transform(data), @contact_v1_url)
    end

    ##
    # === Update Order Item Group.
    # Update an order item group info if you are related to that order.
    #
    # ==== Parameters
    # id:: (Integer) -- Order Item Group Id.
    # data:: (Hash) -- Data to be submited.
    #
    # ==== First Example
    #     data = {
    #       "name": "New Order Item Group Name Updated"
    #     }
    #     @data = @mints_contact.update_order_item_group(130, data)
    def update_order_item_group(id, data)
      return @client.raw("put", "/ecommerce/order-items-groups/#{id}", nil, data_transform(data), @contact_v1_url)
    end

    ##
    # === Delete Order Item Group.
    # Delete an order item group.
    # FIXME: This method doesn't work. Throw no action error. 
    def delete_order_item_group(id)
      return @client.raw("delete", "/ecommerce/order-items-groups/#{id}", nil, nil, @contact_v1_url)
    end

    private

    include MintsHelper

    def session_token?
      if @client.session_token
        return true
      else
        raise "Unauthenticated"
        return false
      end
    end
  end
end
