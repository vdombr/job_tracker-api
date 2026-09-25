module Services
  module JobApps
    class Container
      extend Dry::Core::Container::Mixin
      import Services::Shared::Namespace

      namespace('operations') do
        register('list_job_apps')  { Services::JobApps::Operations::ListJobApps.new }
        register('create_job_app') { Services::JobApps::Operations::CreateJobApp.new }
      end

      namespace('steps') do
        register('create_job_app') { Services::JobApps::Steps::CreateJobApp.new }
        register('filter')         { Services::JobApps::Steps::Filter.new }
      end

      namespace('contracts') do
        register('list_job_apps')  { Services::JobApps::Contracts::ListJobApps.new }
        register('create_job_app') { Services::JobApps::Contracts::CreateJobApp.new }
      end

      namespace('projections') do
        register('common')        { Services::JobApps::Projections::Common.new }
        register('list_job_apps') { Services::JobApps::Projections::ListJobApps.new }
      end
    end
  end
end
