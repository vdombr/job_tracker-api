module Handlers
  module JobApps
    class Container
      extend Dry::Core::Container::Mixin
      import Handlers::Shared::Namespace

      namespace('operations') do
        register('index') { Handlers::JobApps::Operations::Index.new }
      end

      namespace('steps') do
        register('list_job_apps') { Handlers::JobApps::Steps::ListJobApps.new }
      end
    end
  end
end
