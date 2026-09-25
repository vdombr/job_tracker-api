module Services
  module JobApps
    module Contracts
      class UpdateJobApp < ApplicationContract
        params do
          required(:resource).type(Types.Instance(JobApp))
          required(:attributes).schema do
            required(:id).value(Types::Coercible::Integer).filled
            required(:company).value(Types::Coercible::String).filled
            required(:position).value(Types::Coercible::String).filled
            required(:applied_at).value(Types::Params::Date).filled
            optional(:url).maybe(Types::Coercible::String)
            optional(:hr_contact).maybe(Types::Coercible::String)
            optional(:commentary).maybe(Types::Coercible::String)
            optional(:current_stage).maybe(Types::Coercible::String)
          end
          required(:current_user).value(Types::Coercible::Integer).filled
        end
      end
    end
  end
end
