module Services
  module JobApps
    module Operations
      class UpdateJobApp < Rivulet::Operation
        include Import[
          validate: 'shared.steps.validate',
          contract: 'contracts.update_job_app',
          update_job_app: 'steps.update_job_app',
          present: 'shared.steps.present',
          projection: 'projections.common'
        ]

        def call(input = {})
          result = step validate.(input, contract)
          result = step update_job_app.(result)
          result = step present.(result, projection)

          result
        end
      end
    end
  end
end
