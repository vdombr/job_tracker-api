require 'jwt'

module Handlers
  module Shared
    module Utils
      class TokenUtil
        ENCR_ALGORITHM = 'HS256'.freeze
        TOKEN_EXPIRATION_DAYS = 7

        def verify(token)
          encoded_token = JWT::EncodedToken.new(token)
          encoded_token.verify!(signature: { algorithm: ENCR_ALGORITHM, key: token_key })
          encoded_token.payload
        rescue JWT::VerificationError, JWT::Base64DecodeError
          nil
        end

        def generate(user_id)
          payload = { exp: Time.now.to_i + TOKEN_EXPIRATION_DAYS * 86_400, sub: user_id }
          header  = { kid: 'hmac' }

          token = JWT::Token.new(payload: payload, header: header)
          token.sign!(algorithm: ENCR_ALGORITHM, key: token_key)

          token
        end

        private

        def token_key
          Rivulet.config.params.token_key
        end
      end
    end
  end
end
