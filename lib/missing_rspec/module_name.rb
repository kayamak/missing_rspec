require 'pry'

module MissingRspec
  class ModuleName
    attr_reader :app_path, :folder_type

    def initialize(app_path:, folder_type:)
      @app_path = app_path
      @folder_type = folder_type
    end

    def rspecs_per_module_name
      original_module_names = make_original_module_names
      spec_module_names = make_spec_module_names

      target_module_names = find_rspecs_per_module_name(original_module_names, spec_module_names)
      target_module_names
    end

    private

    def make_original_module_names
      models_path = "#{app_path}/app/#{folder_type}"
      fetch_module_names(target_path: models_path, is_rspec: false)
    end

    def make_spec_module_names
      spec_models_path = "#{app_path}/spec/#{folder_type}"
      fetch_module_names(target_path: spec_models_path, is_rspec: true)
    end

    def fetch_module_names(target_path: ,is_rspec:)
      unless File.directory?(target_path)
        if folder_type == target_path.split('/').last
          return {}
        end        
        raise "#{target_path} is not directory." 
      end

      result = Hash.new{ |hash, key| hash[key] = [] }

      trace_dir = lambda do |dir, module_name|
        Dir.chdir(dir)
        dir_files = Dir.glob('*').sort
        lower_dirs = dir_files.select { |df| File.directory?(df) }
        files = dir_files - lower_dirs

        lower_dirs.each do |lower_dir|
          lower_module_name = "#{module_name}#{module_name.blank? ? '' : '::'}#{lower_dir.camelize}"
          trace_dir.call(lower_dir, lower_module_name)
        end

        files.each do |file|
          next unless /.rb$/ =~ file

          replaced_file = is_rspec ? file.sub(/_spec.rb$/, '.rb') : file
          result[module_name] << replaced_file
        end

        Dir.chdir('..')
      end
      trace_dir.call(target_path, '')

      result
    end

    def find_rspecs_per_module_name(original_module_names, spec_module_names)
      target_module_names = Hash.new{ |hash, key| hash[key] = [] }
      original_module_names.each do |module_name, rb_files|
        spec_files = spec_module_names[module_name] || []
        target_files = rb_files - spec_files
        target_module_names[module_name] = target_files if target_files.present?
      end
      target_module_names
    end
  end
end
