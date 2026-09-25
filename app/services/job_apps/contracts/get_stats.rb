module Services
  module JobApps
    module Contracts
      class GetStats < ApplicationContract
        params do
          required(:resource).value(Types.Value(JobApp)).filled
          required(:current_user).value(Types::Coercible::Integer).filled
        end
      end
    end
  end
end
