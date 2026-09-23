module Services
  module Users
    module Operations
      class GetUser < Rivulet::Operation
        include Import[
          validate: 'shared.steps.validate',
          contract: 'contracts.get_user',
          load_user: 'steps.load_user',
          present: 'shared.steps.present',
          projection: 'projections.common'
        ]

        def call(input = {})
          result = step validate.(input, contract)
          result = step load_user.(result)
          result = step present.(result, projection)

          result
        end
      end
    end
  end
end
