module Services
  module Users
    module Steps
      class LoadUser < Rivulet::Step
        def call(input)
          resource, attributes = input.values_at(:resource, :attributes)

          user = resource.where(attributes[:find_by]).first
          return Failure[:not_found, {}] unless user

          input[:resource] = user

          Success(input)
        end
      end
    end
  end
end
