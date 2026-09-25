module Handlers
  module JobApps
    module Steps
      class CreateJobApp < Rivulet::Step
        def call(input)
          result = Services[:job_apps].create_job_app(
            resource: JobApp,
            attributes: input[:params],
            current_user: input[:context][:current_user]
          )

          case result
          in Success(data)
            Success(Rivulet::Response.new(status: 201, body: data))
          in Failure[:validation, errors]
            Failure(Rivulet::Response.new(status: 422, body: { errors: errors }))
          end
        end
      end
    end
  end
end
