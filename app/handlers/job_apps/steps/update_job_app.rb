module Handlers
  module JobApps
    module Steps
      class UpdateJobApp < Rivulet::Step
        def call(input)
          result = Services[:job_apps].update_job_app(
            resource: JobApp,
            attributes: input[:params],
            current_user: input[:context][:current_user]
          )

          case result
          in Success(data)
            Success(Rivulet::Response.new(status: 200, body: data))
          in Failure[:validation, errors]
            Failure(Rivulet::Response.new(status: 422, body: { errors: errors }))
          in Failure[:not_found, _]
            Failure(Rivulet::Response.new(status: 404))
          end
        end
      end
    end
  end
end
