module Handlers
  module Users
    module Steps
      class CreateToken < Rivulet::Step
        include Import[
          token_util: 'shared.utils.token_util'
        ]

        def call(input)
          user  = input[:context][:current_user]
          token    = token_util.generate(user[:id])

          input[:context][:token] = {
            access_token: token.jwt, token_type: 'Bearer', expires_in: token.payload[:exp]
          }

          Success(input)
        end
      end
    end
  end
end
