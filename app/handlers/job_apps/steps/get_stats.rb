module Handlers
  module JobApps
    module Steps
      class GetStats < Rivulet::Step
        include Import[
          failure_responder: 'shared.utils.failure_responder'
        ]

        def call(input)
          result = Services[:job_apps].get_stats(
            resource: JobApp,
            current_user: input[:context][:current_user]
          )

          return failure_responder.call(result) if result.failure?

          Success(Rivulet::Response.new(status: 200, body: result.value!))
        end
      end
    end
  end
end
