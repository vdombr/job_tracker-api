module Handlers
  module JobApps
    module Steps
      class GetStats < Rivulet::Step
        def call(input)
          result = Services[:job_apps].get_stats(
            resource: JobApp,
            current_user: input[:context][:current_user]
          )

          case result
          in Success(data)
            Success(Rivulet::Response.new(status: 200, body: data))
          in Failure[:validation, errors]
            Failure(Rivulet::Response.new(status: 422, body: { errors: errors }))
          end
        end
      end
    end
  end
end
