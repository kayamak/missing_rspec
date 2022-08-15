require 'missing_rspec/folder_types_finder'
require 'missing_rspec/viewer'
require 'missing_rspec/creator'

module MissingRspec
  class Core
    def self.execute(mode:, app_path:, folder_type:)
      app_path ||= ENV['RAILS_APP_PATH']
      raise "Set the rails app path to the rake argument or the environment variable RAILS_APP_PATH." unless app_path

      folder_type ||= 'all'
      folder_types = MissingRspec::FolderTypesFinder.new(app_path).fetch_folder_types
      puts "The following folders are targeted: #{folder_types}"
      if folder_type != 'all'
        folder_types &&= folder_type.split(';').map!(&:strip)
      end

      case mode
      when :viewer
        MissingRspec::Viewer.new(app_path: app_path, folder_types: folder_types).execute
      when :creator
        MissingRspec::Creator.new(app_path: app_path, folder_types: folder_types).execute
      end
    end
  end
end
