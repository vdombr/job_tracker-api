require 'jwt'

module Handlers
  module Shared
    module Utils
      class VerifyToken
        ENCR_ALGORITHM = 'HS256'.freeze
        KEY = 'qwe123'.freeze

        def call(token)
          encoded_token = JWT::EncodedToken.new(token)
          encoded_token.verify!(signature: { algorithm: ENCR_ALGORITHM, key: KEY })
          encoded_token.payload
        rescue JWT::VerificationError
          nil
        end
      end
    end
  end
end
