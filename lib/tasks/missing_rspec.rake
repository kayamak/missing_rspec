require 'missing_rspec/core'

desc "mechanically extracts uncreated RSpecs"
task :missing_rspec, %w[app_path folder_type] => :environment do |_, args|
  MissingRspec::Core.execute(mode: :viewer, app_path: args.app_path, folder_type: args.folder_type)
end

desc "Create an uncreated Rsepc files"
task :missing_rspec_create, %w[app_path folder_type] => :environment do |_, args|
  MissingRspec::Core.execute(mode: :creator, app_path: args.app_path, folder_type: args.folder_type)
end