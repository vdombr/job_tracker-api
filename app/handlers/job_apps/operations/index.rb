module Handlers
  module JobApps
    module Operations
      class Index < Rivulet::Operation
        include Import[
          authenticate: 'shared.steps.authenticate',
          list_job_apps: 'steps.list_job_apps'
        ]

        def call(input = {})
          result = step authenticate.(input)
          result = step list_job_apps.(result)

          result
        end
      end
    end
  end
end
