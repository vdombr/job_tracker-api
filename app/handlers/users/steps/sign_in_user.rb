module Handlers
  module Users
    module Steps
      class SignInUser < Rivulet::Step
        def call(input)
          email, password = input[:params].values_at(:email, :password)

          result = Services[:users].sign_in_user(
            resource: User,
            attributes: {
              find_by: {
                email: email
              },
              password: password
            }
          )

          case result
          in Success(data)
            input[:context][:current_user] = data[:data][:id]

            Success(input)
          in Failure[:validation, errors]
            Failure(Rivulet::Response.new(status: 422, body: { errors: errors }))
          in Failure[:not_found, _] | Failure[:unauthenticated, _]
            Failure(Rivulet::Response.new(status: 401))
          end
        end
      end
    end
  end
end
