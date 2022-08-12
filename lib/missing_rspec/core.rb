require 'missing_rspec/directory'
require 'missing_rspec/folder_types_finder'
require 'missing_rspec/version'

module MissingRspec
  class Core
    attr_reader :app_path

    def initialize(app_path)
      # e.g. /app
      @app_path = app_path || ENV['RAILS_APP_PATH']
      raise "Set the rails app path to the rake argument or the environment variable RAILS_APP_PATH." unless @app_path
    end

    def execute
      folder_types = MissingRspec::FolderTypesFinder.new(app_path).fetch_folder_types
      puts "The following folders are targeted: #{folder_types}"
      folder_types.each do |folder_type|
        missing_tree = create_missing_tree(folder_type)
        print_tree(missing_tree)
      end

      'hogehoge'
    end

    private
    def create_missing_tree(folder_type)
      MissingRspec::Directory.new(app_path: app_path, folder_type: folder_type).missing_tree
    end

    def print_tree(tree)
      puts tree.join("\n")
    end
  end
end
