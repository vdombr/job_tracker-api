module Handlers
  module Users
    module Operations
      class SignIn < Rivulet::Operation
        include Import[
          sign_in_user: 'steps.sign_in_user',
          create_token: 'steps.create_token'
        ]

        def call(input = {})
          result = step sign_in_user.(input)
          result = step create_token.(result)

          result
        end
      end
    end
  end
end
