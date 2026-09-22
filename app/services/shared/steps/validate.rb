module Services
  module Shared
    module Steps
      class Validate < Rivulet::Step
        def call(input, contract)
          result = contract.call(input)

          return Success(result.to_h) if result.success?

          error_messages = result.errors(full: true)
          Failure[:validation, handle_error(error_messages.to_h)]
        end

        private

        def handle_error(errors)
          messages = if errors.key?(:attributes)
                       errors[:attributes]
                     else
                       errors
                     end
          messages = [messages[:filter]] if messages.key?(:filter)
          messages.map do |field, msg|
            { field: field, message: msg }
          end
        end
      end
    end
  end
end
