require 'missing_rspec/viewer'
require 'missing_rspec/creator'

module MissingRspec
  class Core
    def self.execute(mode:, app_path:)
      case mode
      when :viewer
        MissingRspec::Viewer.new(app_path).execute
      when :creator
        MissingRspec::Creator.new(app_path).execute
      end
    end
  end
end
