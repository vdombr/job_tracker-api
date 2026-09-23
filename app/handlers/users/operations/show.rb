module Handlers
  module Users
    module Operations
      class Show < Rivulet::Operation
        include Import[
          authenticate: 'shared.steps.authenticate',
          get_user: 'steps.get_user'
        ]

        def call(input = {})
          result = step authenticate.(input)
          result = step get_user.(result)

          result
        end
      end
    end
  end
end
