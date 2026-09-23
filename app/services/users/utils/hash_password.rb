require 'openssl'
require 'securerandom'

module Services
  module Users
    module Utils
      class HashPassword
        ITERATIONS = 100_000
        KEY_LEN    = 32
        SALT_LEN   = 16

        def call(password)
          salt = SecureRandom.random_bytes(SALT_LEN)
          digest = OpenSSL::KDF.pbkdf2_hmac(
            password,
            salt: salt,
            iterations: ITERATIONS,
            length: KEY_LEN, hash: 'sha256'
          )
          "pbkdf2$#{ITERATIONS}$#{b64(salt)}$#{b64(digest)}"
        end

        private

        def b64(bytes)
          [bytes].pack('m0')
        end
      end
    end
  end
end
