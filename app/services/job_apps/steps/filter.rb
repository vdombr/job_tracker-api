module Services
  module JobApps
    module Steps
      class Filter < Rivulet::Step
        def call(input)
          resource, attributes, current_user = input.values_at(:resource, :attributes, :current_user)

          resource = resource.where(user_id: current_user)
          if attributes[:filter_by]
            resource = current_stage_filter(resource, attributes[:filter_by])
          end

          Success(input.merge(resource: resource))
        end

        private

        def current_stage_filter(resource, filter)
          current_stage = filter[:current_stage]

          return resource unless current_stage

          resource.where(current_stage: current_stage)
        end
      end
    end
  end
end
