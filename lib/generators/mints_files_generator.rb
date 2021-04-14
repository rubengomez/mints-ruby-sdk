class MintsFilesGenerator < Rails::Generators::Base
    source_root(File.expand_path(File.dirname(__FILE__)))
    include Rails::Generators::Actions
    def create_mints_files
      copy_file 'mints_config.yml.erb', 'mints_config.yml.erb'
      copy_file 'mints_user_controller.rb', './app/controllers/api/mints_user_controller.rb'
      copy_file 'mints_contact_controller.rb', './app/controllers/api/v1/mints_contact_controller.rb'
      copy_file 'mints_public_controller.rb', './app/controllers/api/v1/mints_public_controller.rb'
      copy_file 'mints_assets_controller.rb', './app/controllers/mints_assets_controller.rb'
      route <<-eos
        # Mints auto-generated routes (proxy to send request to mints.cloud)
        match '/public-assets/*path' => 'mints_assets#index', via: [:get, :post, :put, :patch, :delete]
        namespace :api, defaults: { format: :json } do
          match '/user/v1/*path' => 'mints_user#index', via: [:get, :post, :put, :patch, :delete]
          match '/contact/v1/*path' => 'mints_contact#index', via: [:get, :post, :put, :patch, :delete]  
          namespace :v1 do     
            match '/contacts/*path' => 'mints_contact#index', via: [:get, :post, :put, :patch, :delete]              
            match '/*path' => 'mints_public#index', via: [:get, :post, :put, :patch, :delete]
          end
        end
      eos
    end
end