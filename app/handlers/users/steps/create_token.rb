module Handlers
  module Users
    module Steps
      class CreateToken < Rivulet::Step
        include Import[
          token_util: 'shared.utils.token_util'
        ]

        def call(input)
          user_id  = input[:context][:current_user]
          token    = token_util.generate(user_id)
          response = Rivulet::Response.new(status: 200, body: token.jwt, format: :text)

          Success(response)
        end
      end
    end
  end
end
