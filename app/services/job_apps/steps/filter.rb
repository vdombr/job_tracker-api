module Services
  module JobApps
    module Steps
      class Filter < Rivulet::Step
        def call(input)
          input => { resource:, attributes:, current_user: }

          resource = resource.where(user_id: current_user)
          resource = resource.order(Sequel.desc(:applied_at))
          if attributes.key? :filter
            resource = current_stage_filter(resource, attributes[:filter])
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
