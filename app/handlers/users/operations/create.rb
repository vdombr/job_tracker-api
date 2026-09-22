module Handlers
  module Users
    module Operations
      class Create < Rivulet::Operation
        include Import[
          create_user: 'steps.create_user'
        ]

        def call(input = {})
          result = step create_user.(input)

          result
        end
      end
    end
  end
end
