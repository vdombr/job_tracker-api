module Handlers
  module Shared
    module Steps
      class Authenticate < Rivulet::Step
        include Import[
          token_util: 'shared.utils.token_util'
        ]

        def call(input)
          header = input.dig(:context, :headers, 'Authorization').to_s
          token = header.sub(/\ABearer\s+/i, '')
          return unauthorized if token.empty?

          payload = token_util.verify(token)
          return unauthorized unless payload && payload['sub']

          input[:context][:current_user] = payload['sub']

          Success(input)
        end

        private

        def unauthorized
          Failure(Rivulet::Response.new(status: 401))
        end
      end
    end
  end
end
