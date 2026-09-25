module Services
  module JobApps
    module Steps
      class UpdateJobApp < Rivulet::Step
        def call(input)
          resource, attributes = input.values_at(:resource, :attributes)
          update_params = attributes.except(:id)

          resource = resource
                     .where(id: attributes[:id], user_id: input[:current_user])
                     .returning
                     .update(update_params)
                     .first

          return Failure[:not_found, {}] if resource.nil?

          Success(input.merge(resource: resource))
        end
      end
    end
  end
end
