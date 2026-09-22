module Services
  module Shared
    module Steps
      class Present < Rivulet::Step
        def call(input, projection)
          resource, meta = input.values_at(:resource, :meta)
          data = projection.call(resource)

          Success(data: data, meta: meta || {})
        end
      end
    end
  end
end
