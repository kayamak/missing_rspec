module MissingRspec
  class Directory
    attr_reader :app_path, :folder_type

    def initialize(app_path:, folder_type:)
      @app_path = app_path
      @folder_type = folder_type
    end

    def missing_tree
      original_tree = make_original_tree
      spec_tree = make_spec_tree

      # Extract <xxx> rows from spec_tree and make them appear in the diff
      title_of_spec_tree = spec_tree.filter { |st| /<.*>/ =~ st }

      missing_spec_tree = original_tree - (spec_tree - title_of_spec_tree)
    end

    private

    def make_original_tree
      models_path = "#{app_path}/app/#{folder_type}"
      fetch_tree(target_path: models_path, is_rspec: false)
    end

    def make_spec_tree
      spec_models_path = "#{app_path}/spec/#{folder_type}"
      fetch_tree(target_path: spec_models_path, is_rspec: true)
    end

    def fetch_tree(target_path: ,is_rspec:)
      unless File.directory?(target_path)
        if folder_type == target_path.split('/').last
          return []
        end        
        raise "#{target_path} is not directory." 
      end

      result = []

      result << "<#{File.basename(target_path)}>"

      trace_dir = lambda do |dir, pre|
        Dir.chdir(dir)
        dir_files = Dir.glob('*').sort
        lower_dirs = dir_files.select { |df| File.directory?(df) }
        files = dir_files - lower_dirs
        end_num = dir_files.size
        line_num = 1

        lower_dirs.each do |lower_dir|
          char0 = (line_num == end_num) ? '└' : '├'
          line_num += 1
          result << "#{pre}#{char0}<#{lower_dir}>"
          char1 = pre + ((char0 == '└') ? '   ' : '│  ')
          trace_dir.call(lower_dir, char1)
        end

        files.each do |file|
          next unless /.rb$/ =~ file

          char = (line_num == end_num) ? '└' : '├'
          line_num += 1

          replaced_file = is_rspec ? file.sub(/_spec.rb$/, '.rb') : file
          result << "#{pre}#{char}#{replaced_file}"
        end

        Dir.chdir('..')
      end
      trace_dir.call(target_path, '  ')

      result
    end

  end
end
