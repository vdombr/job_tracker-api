module Services
  module Users
    module Operations
      class CreateUser < Rivulet::Operation
        include Import[
          validate: 'shared.steps.validate',
          contract: 'contracts.create_user',
          create_user: 'steps.create_user',
          present: 'shared.steps.present',
          projection: 'projections.common'
        ]

        def call(input = {})
          result = step validate.(input, contract)
          result = step create_user.(result)
          result = step present.(result, projection)

          result
        end
      end
    end
  end
end
