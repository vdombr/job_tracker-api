module Services
  module JobApps
    module Contracts
      class CreateJobApp < ApplicationContract
        params do
          required(:resource).value(Types.Value(JobApp)).filled
          required(:attributes).schema do
            required(:company).value(Types::Coercible::String).filled
            required(:position).value(Types::Coercible::String).filled
            required(:applied_at).value(Types::Params::Date).filled
            optional(:url).value(Types::Coercible::String).filled
            optional(:hr_contact).value(Types::Coercible::String).filled
            optional(:commentary).value(Types::Coercible::String).filled
          end
          required(:current_user).value(Types::Coercible::Integer).filled
        end
      end
    end
  end
end
