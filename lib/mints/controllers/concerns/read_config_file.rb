# frozen_string_literal: true

module ReadConfigFile
  extend ActiveSupport::Concern

  included do
    before_action :set_config_variables
  end

  def set_config_variables
    if File.exists?("#{Rails.root}/mints_config.yml.erb")
      template = ERB.new File.new("#{Rails.root}/mints_config.yml.erb").read
      config = YAML.safe_load template.result(binding)

      @host = config.dig('mints', 'host')
      @api_key = config.dig('mints', 'api_key')
      @debug = !!config.dig('sdk', 'debug')
      @redis_config = config['redis_cache']
      @use_cache = config.dig('redis_cache', 'use_cache')

      if @use_cache
        @redis_server = Redis.new(
          host: config.dig('redis_cache', 'redis_host'),
          port: config.dig('redis_cache', 'redis_port') || 6379,
          db: config.dig('redis_cache', 'redis_db') || 1
        )
      end
    end
  end
end