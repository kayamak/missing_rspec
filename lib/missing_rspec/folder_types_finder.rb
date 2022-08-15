module MissingRspec
  class FolderTypesFinder
    attr_reader :app_path

    def initialize(app_path)
      @app_path = app_path
    end

    def fetch_folder_types
      Dir.chdir(app_path)
      Dir.chdir('app')
      fetch_target_folders
    end

    private

    def fetch_target_folders
      folders = Hash.new{ |hash, key| hash[key] = [] }
      
      trace_dir = lambda do |dir, deep_level|
        Dir.chdir(dir)
        dir_files = Dir.glob('*').sort
        lower_dirs = dir_files.select { |df| File.directory?(df) }
        files = dir_files - lower_dirs

        lower_dirs.each do |lower_dir|
          trace_dir.call(lower_dir, deep_level + 1)
        end

        files.each do |file|
          if /.rb$/ =~ file
            folders[deep_level] << dir
            break
          end
        end

        Dir.chdir('..')
      end
      trace_dir.call('.', 0)

      folders[1]
    end
  end
end
