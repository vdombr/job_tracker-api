module Services
  module JobApps
    module Operations
      class GetStats < Rivulet::Operation
        include Import[
          validate: 'shared.steps.validate',
          contract: 'contracts.get_stats',
          build_stats: 'steps.build_stats'
        ]

        def call(input = {})
          result = step validate.(input, contract)
          result = step build_stats.(result)

          result
        end
      end
    end
  end
end
