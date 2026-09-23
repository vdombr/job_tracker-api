module Handlers
  module Shared
    Namespace = Dry::Core::Container::Namespace.new('shared') do
      namespace('steps') do
        register('authenticate') { Handlers::Shared::Steps::Authenticate.new }
      end

      namespace('utils') do
        register('verify_token') { Handlers::Shared::Utils::VerifyToken.new }
      end
    end
  end
end
