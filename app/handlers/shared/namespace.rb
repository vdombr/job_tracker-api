module Handlers
  module Shared
    Namespace = Dry::Core::Container::Namespace.new('shared') do
      namespace('steps') do
        register('authenticate') { Handlers::Shared::Steps::Authenticate.new }
      end

      namespace('utils') do
        register('failure_responder') { Handlers::Shared::Utils::FailureResponder.new }
        register('token_util')        { Handlers::Shared::Utils::TokenUtil.new }
      end
    end
  end
end
