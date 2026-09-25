module Services
  module JobApps
    module Operations
      class CreateJobApp < Rivulet::Operation
        include Import[
          validate: 'shared.steps.validate',
          contract: 'contracts.create_job_app',
          create_job_app: 'steps.create_job_app',
          present: 'shared.steps.present',
          projection: 'projections.common'
        ]

        def call(input = {})
          result = step validate.(input, contract)
          result = step create_job_app.(result)
          result = step present.(result, projection)

          result
        end
      end
    end
  end
end
