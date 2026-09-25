module Handlers
  module JobApps
    class Container
      extend Dry::Core::Container::Mixin
      import Handlers::Shared::Namespace

      namespace('operations') do
        register('create') { Handlers::JobApps::Operations::Create.new }
        register('index')  { Handlers::JobApps::Operations::Index.new }
      end

      namespace('steps') do
        register('create_job_app') { Handlers::JobApps::Steps::CreateJobApp.new }
        register('list_job_apps')  { Handlers::JobApps::Steps::ListJobApps.new }
      end
    end
  end
end
