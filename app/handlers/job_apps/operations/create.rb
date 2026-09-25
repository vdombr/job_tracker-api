module Handlers
  module JobApps
    module Operations
      class Create < Rivulet::Operation
        include Import[
          authenticate: 'shared.steps.authenticate',
          create_job_app: 'steps.create_job_app'
        ]

        def call(input = {})
          result = step authenticate.(input)
          result = step create_job_app.(result)

          result
        end
      end
    end
  end
end
