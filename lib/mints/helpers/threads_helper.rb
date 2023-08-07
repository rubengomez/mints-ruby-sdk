require 'concurrent/executor/thread_pool_executor'

module ThreadsHelper

  def make_multiple_request(calls)
    set_threads_config
    payload_to_return = []
    now = Time.now
    calls = [calls] if !calls.kind_of?(Array) || (calls.kind_of?(Array) && calls.first.kind_of?(String))

    if @debug
      puts "min_threads_per_pool: #{@min_threads_per_pool}"
      puts "max_threads_per_pool: #{@max_threads_per_pool}"
      puts "max_threads_queue: #{@max_threads_queue}"
    end

    pool = Concurrent::ThreadPoolExecutor.new(
      min_threads: @min_threads_per_pool,
      max_threads: @max_threads_per_pool,
      max_queue: @max_threads_queue,
      fallback_policy: :caller_runs
    )

    calls.each_with_index do |call_data, index|
      pool.post do
        begin
          payload_to_return[index] = make_call(call_data)
        rescue => e
          payload_to_return[index] = e
        end
      end
    end

    # tell the pool to shutdown in an orderly fashion, allowing in progress work to complete
    pool.shutdown
    # now wait for all work to complete, wait as long as it takes
    pool.wait_for_termination

    if @debug
      end_time = Time.now
      puts "Time to make all calls: #{end_time - now}"
    end

    payload_to_return
  end

  private

  def set_threads_config
    if File.exists?("#{Rails.root}/mints_config.yml.erb")
      template = ERB.new File.new("#{Rails.root}/mints_config.yml.erb").read
      config = YAML.safe_load template.result(binding)
      mints_config = get_mints_config(config)
      @debug = !!config['sdk']['debug']

      # All threads config
      @min_threads_per_pool = mints_config['min_threads_per_pool'] || 2
      @max_threads_per_pool = mints_config['max_threads_per_pool'] || 2
      @max_threads_queue = mints_config['max_threads_queue'] || 10
    end
  end

  def get_mints_config(config)
    config['mints'].kind_of?(Hash) ? config['mints'] : {}
  end

  def make_call(call_data)
    action, *all_options = generate_raw_data(call_data)

    if if_is_raw_action(action)
      self.client.raw(action, *all_options)
    else
      self.send(action, *all_options.compact)
    end
  end

  def if_is_raw_action(action)
    http_actions = %w[get create post update put patch delete destroy]
    http_actions.include?(action.downcase)
  end

  def generate_raw_data(payload)
    action = raw_attribute_data(payload, 'action')
    url = raw_attribute_data(payload, 'url', 1)
    options = raw_attribute_data(payload, 'options', 2)
    data = raw_attribute_data(payload, 'data', 3)
    base_url = raw_attribute_data(payload, 'base_url', 4)
    compatibility_options = raw_attribute_data(payload, 'compatibility_options', 5)
    only_tracking = raw_attribute_data(payload, 'only_tracking', 6)

    [action, url, options, data, base_url, compatibility_options, only_tracking]
  end

  def raw_attribute_data(payload, attribute, array_index = 0)
    attribute_data = nil

    if payload.kind_of? Array
      attribute_data = payload[array_index]
    elsif payload.kind_of? Hash
      if payload.key? attribute
        attribute_data = payload[attribute]
      elsif payload.key? attribute.to_sym
        attribute_data = payload[attribute.to_sym]
      end
    end

    attribute_data
  end
end
