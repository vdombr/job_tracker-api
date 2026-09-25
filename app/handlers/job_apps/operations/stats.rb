module Handlers
  module JobApps
    module Operations
      class Stats < Rivulet::Operation
        include Import[
          authenticate: 'shared.steps.authenticate',
          get_stats: 'steps.get_stats'
        ]

        def call(input = {})
          result = step authenticate.(input)
          result = step get_stats.(result)

          result
        end
      end
    end
  end
end
