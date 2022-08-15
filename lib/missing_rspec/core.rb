require 'missing_rspec/viewer'
require 'missing_rspec/creator'

module MissingRspec
  class Core
    def self.execute(mode:, app_path:, folder_type:)
      folder_type ||= 'all' 
      case mode
      when :viewer
        MissingRspec::Viewer.new(app_path: app_path, folder_type: folder_type).execute
      when :creator
        MissingRspec::Creator.new(app_path: app_path, folder_type: folder_type).execute
      end
    end
  end
end
