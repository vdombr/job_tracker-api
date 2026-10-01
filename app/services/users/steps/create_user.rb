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
          key, msg = e.message.match('Key \((\w+)\)=\([a-zA-Z@.]+\) ([\w\s]+)').captures

          Failure[:conflict, [{ field: key, message: [msg] }]]
        end
      end
    end
  end
end
