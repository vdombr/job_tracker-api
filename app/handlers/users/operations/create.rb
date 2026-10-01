module Handlers
  module Users
    module Operations
      class Create < Rivulet::Operation
        include Import[
          create_user: 'steps.create_user',
          create_token: 'steps.create_token',
          respond_success: 'steps.respond_success'
        ]

        def call(input = {})
          result = step create_user.(input)
          result = step create_token.(result)
          result = step respond_success.(result)

          result
        end
      end
    end
  end
end
