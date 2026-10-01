module Handlers
  module JobApps
    module Steps
      class UpdateJobApp < Rivulet::Step
        include Import[
          failure_responder: 'shared.utils.failure_responder'
        ]

        def call(input)
          result = Services[:job_apps].update_job_app(
            resource: JobApp,
            attributes: input[:params],
            current_user: input[:context][:current_user]
          )

          return failure_responder.call(result) if result.failure?

          Success(Rivulet::Response.new(status: 200, body: result.value!))
        end
      end
    end
  end
end
