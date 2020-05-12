class MintsFilesGenerator < Rails::Generators::Base
    source_root(File.expand_path(File.dirname(__FILE__)))
    def create_mints_files
      copy_file 'mints_config.yml', 'mints_config.yml'
    end
end