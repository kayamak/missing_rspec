require 'missing_rspec/core'

desc "mechanically extracts uncreated RSpecs"
task :missing_rspec, ['app_path'] => :environment do |_, args|
  MissingRspec::Core.new(args.app_path).execute
end