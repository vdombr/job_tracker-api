module Services
  module Users
    module Contracts
      class GetUser < ApplicationContract
        params do
          required(:resource).value(Types.Value(User)).filled
          required(:attributes).schema do
            required(:find_by).schema do
              required(:id).value(Types::Coercible::Integer).filled
            end
          end
        end
      end
    end
  end
end
