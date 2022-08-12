require 'active_model/railtie'

module MissingRspec
  class Railtie < ::Rails::Railtie
    rake_tasks do
      load "tasks/missing_rspec.rake"
    end
  end
end
