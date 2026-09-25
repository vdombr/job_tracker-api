module Services
  module JobApps
    module Operations
      class ListJobApps < Rivulet::Operation
        include Import[
          validate: 'shared.steps.validate',
          contract: 'contracts.list_job_apps',
          filter: 'steps.filter',
          paginate: 'shared.steps.paginate',
          present: 'shared.steps.present',
          projection: 'projections.list_job_apps'
        ]

        def call(input = {})
          result = step validate.(input, contract)
          result = step filter.(result)
          result = step paginate.(result)
          result = step present.(result, projection)

          result
        end
      end
    end
  end
end
