module Services
  module JobApps
    class Container
      extend Dry::Core::Container::Mixin
      import Services::Shared::Namespace

      namespace('operations') do
        register('list_job_apps') { Services::JobApps::Operations::ListJobApps.new }
      end

      namespace('steps') do
        register('filter') { Services::JobApps::Steps::Filter.new }
      end

      namespace('contracts') do
        register('list_job_apps') { Services::JobApps::Contracts::ListJobApps.new }
      end

      namespace('projections') do
        register('list_job_apps') { Services::JobApps::Projections::ListJobApps.new }
      end
    end
  end
end
