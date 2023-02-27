module Mints

  module Errors

    class NonSupportedRubyVersionError < RuntimeError; end

    class DynamicError < RuntimeError
      ERRORS = {
        '401' => 'AccessDeniedException',
        '404' => 'ResourceNotFoundException',
        '422' => 'ValidationException',
        '405' => 'MethodNotAllowed',
        'default' => 'InternalServerException',
      }

      def initialize(client, title, detail, http_status, response)
        @http_status = http_status
        @error = error_class.constantize&.new(client, title, detail, http_status, response)
      end

      attr_reader :error, :http_status

      def to_s
        error_class
      end

      private

      def error_class
        "Mints::Errors::#{ERRORS[http_status.to_s] || ERRORS['default']}"
      end
    end

    class ServiceError < RuntimeError
      # @param [Client] client
      # @param [String] title
      # @param [String] detail
      # @param [Integer] http_status
      # @param [String Object Array] response
      def initialize(client, title, detail, http_status, response)
        @title = title
        @client = client
        @response = response
        @http_status = http_status
        @detail = detail && !detail.empty? ? detail : self.class.to_s

        super(@detail)
      end

      # @return [String]
      def detail
        @detail
      end

      def to_h(extra_fields = {})
        default_fields = {
          client: client,
          title: title,
          detail: detail,
          http_status: http_status,
          response: response
        }

        default_fields.merge(extra_fields)
      end

      def to_s
        to_h.to_s
      end

      attr_reader :client, :detail, :title, :http_status, :response
    end

    class AccessDeniedException < ServiceError; end

    class ResourceNotFoundException < ServiceError; end

    class MethodNotAllowed < ServiceError; end

    class ValidationException < ServiceError

      def to_h
        super(errors_hash)
      end

      def errors_hash
        {
          errors: response.keys.reduce([]) {|carry, error_key| carry + response[error_key]}
        }
      end

      attr_reader :failed_validations
    end

    class InternalServerException < ServiceError; end

  end
end