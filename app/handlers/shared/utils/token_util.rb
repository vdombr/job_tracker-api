require 'jwt'

module Handlers
  module Shared
    module Utils
      class TokenUtil
        ENCR_ALGORITHM = 'HS256'.freeze
        KEY = 'qwe123'.freeze

        def verify(token)
          encoded_token = JWT::EncodedToken.new(token)
          encoded_token.verify!(signature: { algorithm: ENCR_ALGORITHM, key: KEY })
          encoded_token.payload
        rescue JWT::VerificationError
          nil
        end

        def generate(user_id)
          payload = { exp: Time.now.to_i + 60, sub: user_id }
          header  = { kid: 'hmac' }

          token = JWT::Token.new(payload: payload, header: header)
          token.sign!(algorithm: ENCR_ALGORITHM, key: KEY)

          token
        end
      end
    end
  end
end
