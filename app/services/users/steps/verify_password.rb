module Services
  module Users
    module Steps
      class VerifyPassword < Rivulet::Step
        include Import[
          verify_password: 'utils.verify_password'
        ]

        def call(input)
          password = input[:attributes][:password]
          hash = input[:resource].password_hash

          return not_found unless verify_password.call(password, hash)

          Success(input)
        end

        private

        def not_found
          Failure[:not_found, {}]
        end
      end
    end
  end
end
