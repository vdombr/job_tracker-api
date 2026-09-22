module Handlers
  module Users
    class Container
      extend Dry::Core::Container::Mixin
      import Handlers::Shared::Namespace

      namespace('operations') do
        register('create') { Handlers::Users::Operations::Create.new }
      end

      namespace('steps') do
        register('create_user') { Handlers::Users::Steps::CreateUser.new }
      end
    end
  end
end
