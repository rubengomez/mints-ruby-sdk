module TestingModeHelper
  def get_json_test_response(action: '', url: '', options: {})
    responses = get_json_responses
    option_keys = options.keys

    responses.find do |r|
      r['url'] == url && r['action'] == action && option_keys.all? do |option_key|
        options[option_key] == r['options'].with_indifferent_access[option_key]
      end
    end
  end

  def update_json_test_responses(action: '', url: '', options: {}, response: nil)
    responses = get_json_responses
    responses << {
      url: url.gsub('.tba.', '.patata.'),
      options: options,
      action: action,
      response: response ? JSON.parse(response) : {},
      api_version: get_api_version(response)
    }
    write_file(responses)
  end

  def get_json_responses
    if File.exists?(get_json_filename)
      json_file = open_file(get_json_filename)
      json_file.is_a?(Array) ? json_file : []
    else
      write_file([])
      []
    end
  rescue StandardError => e
    []
  end

  def open_file(file_name)
    File.open(file_name, 'r') do |file|
      JSON.parse(file.read)
    end
  rescue StandardError => e
    []
  end

  def write_file(data)
    File.open(get_json_filename, 'w') do |file|
      file.puts JSON.pretty_generate(data)
    end
  end

  def get_json_filename
    "#{Rails.root}/cxf_test_responses.json"
  end

  def get_api_version(response)
    JSON.parse(response)['meta']['version']
  rescue StandardError
    'No release version found'
  end
end