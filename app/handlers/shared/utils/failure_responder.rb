module Handlers
  module Shared
    module Utils
      class FailureResponder
        include Dry::Monads[:result]

        class UnexpectedInput < StandardError; end

        def call(result)
          raise unexpected_input unless result.failure?

          case result
          in Failure[:not_found, _]
            Failure(Rivulet::Response.new(status: 404))
          in Failure[:conflict, errors]
            Failure(Rivulet::Response.new(status: 409, body: { errors: errors }))
          in Failure[:validation, errors]
            Failure(Rivulet::Response.new(status: 422, body: { errors: errors }))
          end
        end

        private

        def unexpected_input
          UnexpectedInput.new('Passed value is not a failure monad')
        end
      end
    end
  end
end
