require 'missing_rspec/tree'
require 'missing_rspec/version'

module MissingRspec
  class Viewer
    attr_reader :app_path, :folder_types

    def initialize(app_path:, folder_types:)
      # e.g. app_path:/app
      @app_path = app_path
      @folder_types = folder_types
    end

    def execute
      folder_types.each do |folder_type|
        missing_tree = create_missing_tree(folder_type)
        print_tree(missing_tree)
      end
    end

    private
    def create_missing_tree(folder_type)
      MissingRspec::Tree.new(app_path: app_path, folder_type: folder_type).missing_tree
    end

    def print_tree(tree)
      puts tree.join("\n")
    end
  end
end
