module Services
  module JobApps
    class Container
      extend Dry::Core::Container::Mixin
      import Services::Shared::Namespace

      namespace('operations') do
        register('get_stats') { Services::JobApps::Operations::GetStats.new }
        register('list_job_apps')  { Services::JobApps::Operations::ListJobApps.new }
        register('create_job_app') { Services::JobApps::Operations::CreateJobApp.new }
        register('update_job_app') { Services::JobApps::Operations::UpdateJobApp.new }
      end

      namespace('steps') do
        register('build_stats') { Services::JobApps::Steps::BuildStats.new }
        register('update_job_app') { Services::JobApps::Steps::UpdateJobApp.new }
        register('create_job_app') { Services::JobApps::Steps::CreateJobApp.new }
        register('filter')         { Services::JobApps::Steps::Filter.new }
      end

      namespace('contracts') do
        register('get_stats') { Services::JobApps::Contracts::GetStats.new }
        register('list_job_apps')  { Services::JobApps::Contracts::ListJobApps.new }
        register('create_job_app') { Services::JobApps::Contracts::CreateJobApp.new }
        register('update_job_app') { Services::JobApps::Contracts::UpdateJobApp.new }
      end

      namespace('projections') do
        register('common')        { Services::JobApps::Projections::Common.new }
        register('list_job_apps') { Services::JobApps::Projections::ListJobApps.new }
      end
    end
  end
end
