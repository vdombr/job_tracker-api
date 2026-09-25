module Handlers
  module JobApps
    module Operations
      class Update < Rivulet::Operation
        include Import[
          authenticate: 'shared.steps.authenticate',
          update_job_app: 'steps.update_job_app'
        ]

        def call(input = {})
          result = step authenticate.(input)
          result = step update_job_app.(result)

          result
        end
      end
    end
  end
end
