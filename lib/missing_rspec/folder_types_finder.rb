module MissingRspec
  class FolderTypesFinder
    EXCLUDED_FOLDER_TYPES = %w[assets javascript views]

    attr_reader :app_path

    def initialize(app_path)
      @app_path = app_path
    end

    def fetch_folder_types
      Dir.chdir(app_path)
      Dir.chdir('app')
      folder_types = Dir.glob('*/')
      folder_types.each(&:chop!)
      (folder_types - EXCLUDED_FOLDER_TYPES)
    end
  end
end
