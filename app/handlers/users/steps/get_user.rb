module Handlers
  module Users
    module Steps
      class GetUser < Rivulet::Step
        def call(input)
          result = Services[:users].get_user(
            resource: User,
            attributes: {
              find_by: {
                id: input[:context][:current_user]
              }
            }
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
