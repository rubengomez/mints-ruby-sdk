Gem::Specification.new do |s|
  s.name = %q{mints}
  s.version = "0.0.26"
  s.date = %q{2022-11-08}
  s.summary = %q{MINTS gem allows to connect your Rails App to MINTS.CLOUD}
  s.authors = %q{Ruben Gomez Garcia, Omar Mora, Luis Payan, Oscar Castillo}
  s.homepage  = "https://github.com/rubengomez/mints-ruby-sdk"
  s.files = [
    "Gemfile",
    "README.md",
    "lib/mints_helper.rb",
    "lib/client.rb",
    "lib/user.rb",
    "lib/contact.rb",
    "lib/pub.rb",
    "lib/mints.rb",
    'lib/generators/mints_files_generator.rb',
    'lib/generators/mints_link.rb',
    'lib/generators/mints_config.yml.erb',
    'lib/generators/short_link_controller.rb',
    'lib/generators/mints_public_controller.rb',
    'lib/generators/mints_assets_controller.rb',
    'lib/generators/mints_contact_controller.rb',
    'lib/generators/mints_user_controller.rb',
    'lib/mints/controllers/base_controller.rb',
    'lib/mints/controllers/base_api_controller.rb',
    'lib/mints/controllers/admin_base_controller.rb',
    'lib/mints/controllers/public_api_controller.rb',
    'lib/mints/controllers/contact_api_controller.rb',
    'lib/mints/controllers/user_api_controller.rb'
  ]
  s.files += Dir["lib/user/**/*.rb"]
  s.require_paths = ["app", "lib"]
  s.add_runtime_dependency 'json', '>= 1.8.3'
  s.add_runtime_dependency 'httparty', '>= 0.18', '< 0.22'
  s.add_runtime_dependency 'redis', '~> 4.2.2', '>= 4.2.2'
  s.add_runtime_dependency 'addressable', '~> 2.7.0', '>= 2.7.0'
  s.add_runtime_dependency 'rails-reverse-proxy', '~> 0.9.1', '>= 0.9.1'
end
