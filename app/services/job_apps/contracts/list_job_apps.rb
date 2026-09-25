module Services
  module JobApps
    module Contracts
      class ListJobApps < ApplicationContract
        params do
          required(:resource).value(Types.Value(JobApp)).filled
          required(:attributes).schema do
            optional(:filter).schema do
              optional(:current_stage).value(Types::Coercible::String, included_in?: JobApp::STAGES).filled
            end
            optional(:paginate).schema do
              optional(:page).value(Types::Coercible::Integer).filled
              optional(:limit).value(Types::Coercible::Integer).filled
            end
          end
          required(:current_user).value(Types::Coercible::Integer).filled
        end
      end
    end
  end
end
