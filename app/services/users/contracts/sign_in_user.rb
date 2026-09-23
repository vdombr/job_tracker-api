module Services
  module Users
    module Contracts
      class SignInUser < ApplicationContract
        params do
          required(:resource).value(Types.Value(User)).filled
          required(:attributes).schema do
            required(:find_by).schema do
              required(:email).value(Types::Coercible::String).filled
            end
            required(:password).value(Types::Coercible::String).filled
          end
        end
      end
    end
  end
end
