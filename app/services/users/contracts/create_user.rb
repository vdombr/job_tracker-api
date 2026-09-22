module Services
  module Users
    module Contracts
      class CreateUser < ApplicationContract
        params do
          required(:resource).value(Types.Value(User)).filled
          required(:attributes).schema do
            required(:name).value(Types::Coercible::String, max_size?: 255).filled
            required(:email).value(Types::Coercible::String, format?: URI::MailTo::EMAIL_REGEXP).filled
            required(:password).value(Types::Coercible::String).filled
          end
        end
      end
    end
  end
end
