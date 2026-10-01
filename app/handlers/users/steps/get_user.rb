module Handlers
  module Users
    module Steps
      class GetUser < Rivulet::Step
        include Import[
          failure_responder: 'shared.utils.failure_responder'
        ]

        def call(input)
          result = Services[:users].get_user(
            resource: User,
            attributes: {
              find_by: {
                id: input[:context][:current_user]
              }
            }
          )

          return failure_responder.call(result) if result.failure?

          Success(Rivulet::Response.new(status: 200, body: result.value!))
        end
      end
    end
  end
end
