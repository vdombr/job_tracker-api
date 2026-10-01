module Handlers
  module Users
    module Steps
      class CreateUser < Rivulet::Step
        include Import[
          failure_responder: 'shared.utils.failure_responder'
        ]

        def call(input)
          result = Services[:users].create_user(
            resource: User,
            attributes: input[:params]
          )

          return failure_responder.call(result) if result.failure?

          input[:context].merge!(
            current_user: result.value![:data],
            action: :create
          )

          Success(input)
        end
      end
    end
  end
end
