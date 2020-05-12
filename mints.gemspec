Gem::Specification.new do |s|
  s.name = %q{mints}
  s.version = "0.0.4"
  s.date = %q{2020-05-12}
  s.summary = %q{MINTS gem allows to connect your Rails App to MINTS.CLOUD}
  s.authors = %q{Ruben Gomez Garcia, Omar Mora}
  s.homepage  = "https://github.com/rubengomez/mints-ruby-sdk"
  s.files = [
    "Gemfile",
    "Readme.md",
    "lib/client.rb",
    "lib/user.rb",
    "lib/contact.rb",
    "lib/pub.rb",
    "lib/mints.rb",
    'lib/generators/mints_files_generator.rb',
    'lib/generators/mints_config.yml',
    'lib/mints/controllers/mints_base_controller.rb'
  ]
  s.require_paths = ["app", "lib"]
  s.add_runtime_dependency 'json', '~> 1.8.3', '>= 1.8.3'
  s.add_runtime_dependency 'httparty', '~> 0.18.0', '>= 0.18.0'
  s.add_runtime_dependency 'addressable', '~> 2.7.0', '>= 2.7.0'
end
