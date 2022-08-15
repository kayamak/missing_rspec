require 'missing_rspec/tree'
require 'missing_rspec/folder_types_finder'
require 'missing_rspec/module_name'
require 'fileutils'

module MissingRspec
  class Creator
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
        rspecs_per_module_name = fetch_rspecs_per_module_name(folder_type)
        create_rspecs(folder_type, rspecs_per_module_name)
      end
    end

    private

    def fetch_rspecs_per_module_name(folder_type)
      MissingRspec::ModuleName.new(app_path: app_path, folder_type: folder_type).rspecs_per_module_name
    end

    def create_rspecs(folder_type, rspecs_per_module_name)
      rspecs_per_module_name.each do |module_name, rspecs|
        rspec_full_path = make_rspec_full_path(folder_type, module_name)

        rspecs.each do |rspec|
          rspec_file_name = rspec.sub(/.rb$/, '_spec.rb')
          rspec_full_path_file_name = "#{rspec_full_path}#{rspec_file_name}"
          class_name = rspec.sub(/.rb$/, '').classify
          puts "=====> module_name:#{module_name}, rspec_full_path_file_name:#{rspec_full_path_file_name}, class_name:#{class_name}"
          full_class_name = build_full_class_name(module_name, class_name)
          rspec_content = build_rspec_content(full_class_name, folder_type)

          puts "rspec_content=====>#{rspec_content}"
          write_rspec_content(rspec_full_path_file_name, rspec_content)
        end
      end
    end

    def build_full_class_name(module_name, class_name)
      if module_name == "Concerns"
        "#{'"'}#{class_name}#{'"'}"
      else
        "#{module_name}#{module_name.blank? ? '' : '::'}#{class_name}"
      end
    end

    def make_rspec_full_path(folder_type, module_name)
      module_path = module_name.split('::').map(&:underscore).join('/')
      rspec_full_path = "#{app_path}/spec/#{folder_type}/#{module_path}#{module_path.blank? ? '' : '/'}"
      FileUtils.mkdir_p(rspec_full_path)
      rspec_full_path
    end

    def build_rspec_content(full_class_name, folder_type)
      <<~EOS
        RSpec.describe #{full_class_name}, type: :#{folder_type.singularize} do
        end
      EOS
    end

    def write_rspec_content(rspec_full_path_file_name, rspec_content)
      File.open(rspec_full_path_file_name, "w") do |io|
        io.write(rspec_content)
      end
    end
  end
end
