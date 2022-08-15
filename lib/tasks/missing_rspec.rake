require 'missing_rspec/core'

desc "mechanically extracts uncreated RSpecs"
task :missing_rspec, ['app_path'] => :environment do |_, args|
  MissingRspec::Core.execute(mode: :viewer, app_path: args.app_path)
end

desc "Create an uncreated Rsepc files"
task :missing_rspec_create, ['app_path'] => :environment do |_, args|
  MissingRspec::Core.execute(mode: :creator, app_path: args.app_path)
end