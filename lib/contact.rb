# frozen_string_literal: true

require_relative './client'
require_relative './mints/helpers/mints_helper'
require_relative './mints/helpers/threads_helper'
require_relative './contact/content/content'
require_relative './contact/config/config'
require_relative './contact/ecommerce/ecommerce'

include ActionController::Cookies

module Mints
  class Contact
    include ContactConfig
    include ContactContent
    include ContactEcommerce
    include MintsHelper
    include ThreadsHelper

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
      @client = Mints::Client.new(host, api_key, 'contact', session_token, contact_token_id, nil, debug)
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
    #       email: 'email@example.com',
    #       given_name: 'Given Name',
    #       last_name: 'Last Name',
    #       password: 'password'
    #     }
    #     @mints_contact.register(data);
    def register(data)
      @client.raw('post', '/contacts/register', nil, data_transform(data))
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
    #     @mints_contact.login('email@example.com', 'password')
    def login(email, password)
      data = {
        email: email,
        password: password
      }
      response = @client.raw('post', '/contacts/login', nil, data_transform(data))
      @client.session_token = response['session_token'] if response.key? 'session_token'

      response
    end

    ##
    # === Recover Password.
    # Send a email that contains a token to a contact. That token will be used in reset_password to establish a new password.
    #
    # ==== Parameters
    # data:: (Hash) -- It's a data key where will be hosted the destination email.
    #
    # ==== Example
    #     data = { email: 'email@example.com' }
    #     @mints_contact.recover_password(data)
    def recover_password(data)
      @client.raw('post', '/contacts/recover-password', nil, data_transform(data))
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
    #       email: 'email@example.com',
    #       password: 'password',
    #       password_confirmation: 'password',
    #       token: '644aa3aa0831d782cc42e42b11aedea9a2234389af4f429a8d96651295ecfa09'
    #     }
    #     @mints_contact.reset_password(data)
    def reset_password(data)
      @client.raw('post', '/contacts/reset-password', nil, data_transform(data))
    end

    ##
    # === OAuth Login.
    # Login a contact using oauth.
    def oauth_login(data)
      @client.raw('post', '/contacts/oauth-login', nil, data)
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
    #       'd8618c6d-a165-41cb-b3ec-d053cbf30059:zm54HtRdfHED8dpILZpjyqjPIceiaXNLfOklqM92fveBS0nDtyPYBlI4CPlPe3zq'
    #     )
    def magic_link_login(token)
      response = @client.raw('get', "/contacts/magic-link-login/#{token}", nil, '/api/v1')
      @client.session_token = response['session_token'] if response.key? 'session_token'

      response
    end

    ##
    # === Send Magic Link.
    # Send magic link to contact by email. That magic link will be used in magic_link_login method.
    #
    # ==== Parameters
    # email_or_phone:: (String) -- Contact's email.
    # template_slug:: (String) -- Email template's slug to be used in the email.
    # redirectUrl:: (String) -- Url to be redirected in the implemented page.
    # lifeTime:: (Integer) -- Maximum time of use in minutes.
    # maxVisits:: (Integer) -- The maximum number of uses of a token.
    #
    # ==== First Example
    #     @mints_contact.send_magic_link('email@example.com', 'template_slug')
    #
    # ==== Second Example
    #     @mints_contact.send_magic_link('+526561234567', 'template_slug', '', 1440, 3, 'whatsapp')
    def send_magic_link(email_or_phone, template_slug, redirect_url = '', life_time = 1440, max_visits = nil, driver = 'email')
      data = {
        driver: driver,
        lifeTime: life_time,
        maxVisits: max_visits,
        redirectUrl: redirect_url,
        templateId: template_slug
      }
      if %w[sms whatsapp].include? driver
        data['phone'] = email_or_phone
      else
        data['email'] = email_or_phone
      end
      @client.raw('post', '/contacts/magic-link', nil, data_transform(data), '/api/v1')
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
    #       attributes: true,
    #       taxonomies: true
    #     }
    #     @data = @mints_contact.me(options)
    def me(options = nil)
      @client.raw('get', '/me', options, nil, @contact_v1_url)
    end

    ##
    # === Status.
    # Get contact logged status.
    #
    # ==== Example
    #     @data = @mints_contact.status
    def status
      @client.raw('get', '/status', nil, nil, @contact_v1_url)
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
    #       given_name: 'Given Name',
    #       last_name: 'Last Name'
    #     }
    #     @data = @mints_contact.update(data)
    def update(data)
      @client.raw('put', '/update', nil, data_transform(data), @contact_v1_url)
    end

    ##
    # === Logout.
    # Ends a contact session previously logged.
    #
    # ==== Example
    #     @data = @mints_contact.logout
    def logout
      if session_token?
        response = @client.raw('post', '/logout', nil, nil, @contact_v1_url)
        @client.session_token = nil if response['success']

        response
      end
    end

    ##
    # === Change Password.
    # Change password without email. To change the password a contact must be logged.
    #
    # ==== Parameters
    # data:: (Hash) -- A new password allocated in a data key.
    #
    # ==== Example
    #     data = { password: 'new_password' }
    #     @data = @mints_contact.change_password(data)
    def change_password(data)
      @client.raw('post', '/change-password', nil, data_transform(data), @contact_v1_url)
    end

    private

    include MintsHelper

    def session_token?
      unless @client.session_token
        Mints::DynamicError.new(@client, 'Unauthorized', 'Attach contact session token', 401, nil)
      end

      true
    end
  end
end
