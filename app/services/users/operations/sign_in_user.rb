module Services
  module Users
    module Operations
      class SignInUser < Rivulet::Operation
        include Import[
          validate: 'shared.steps.validate',
          contract: 'contracts.sign_in_user',
          load_user: 'steps.load_user',
          verify_password: 'steps.verify_password',
          present: 'shared.steps.present',
          projection: 'projections.sign_in_user'
        ]

        def call(input = {})
          result = step validate.(input, contract)
          result = step load_user.(result)
          result = step verify_password.(result)
          result = step present.(result, projection)

          result
        end
      end
    end
  end
end
