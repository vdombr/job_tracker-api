require 'openssl'
require 'securerandom'

module Services
  module Users
    module Utils
      class VerifyPassword
        def call(password, encoded)
          return false if encoded.nil? || encoded.empty?

          scheme, iter, salt_b64, hash_b64 = encoded.split('$')
          return false unless scheme == 'pbkdf2'

          salt     = deb64(salt_b64)
          expected = deb64(hash_b64)
          actual = OpenSSL::KDF.pbkdf2_hmac(
            password,
            salt: salt,
            iterations: iter.to_i,
            length: expected.bytesize, hash: 'sha256'
          )
          OpenSSL.fixed_length_secure_compare(actual, expected)
        rescue StandardError
          false
        end

        private

        def deb64(str)
          str.unpack1('m0')
        end
      end
    end
  end
end
