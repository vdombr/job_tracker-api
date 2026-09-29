module Services
  module Users
    module Steps
      class CreateUser < Rivulet::Step
        include Import[
          hash_password: 'utils.hash_password'
        ]

        def call(input)
          input => { resource:, attributes: }

          input[:resource] = resource.create(
            name: attributes[:name],
            email: attributes[:email],
            password_hash: hash_password.call(attributes[:password])
          )

          Success(input)
        rescue Sequel::UniqueConstraintViolation => e
          Failure[:conflict, e.message]
        end
      end
    end
  end
end
