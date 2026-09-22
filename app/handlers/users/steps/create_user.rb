module Handlers
  module Users
    module Steps
      class CreateUser < Rivulet::Step
        def call(input)
          result = Services[:users].create_user(
            resource: User,
            attributes: input[:params]
          )

          case result
          in Success(data)
            Success(Rivulet::Response.new(status: 201, body: data))
          in Failure[:validation, errors]
            Failure(Rivulet::Response.new(status: 422, body: { errors: errors }))
          in Failure[:conflict, _]
            Failure(Rivulet::Response.new(status: 409, body: { errors: 'This email already exists' }))
          end
        end
      end
    end
  end
end
