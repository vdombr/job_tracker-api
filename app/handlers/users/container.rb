module Handlers
  module Users
    class Container
      extend Dry::Core::Container::Mixin
      import Handlers::Shared::Namespace

      namespace('operations') do
        register('create') { Handlers::Users::Operations::Create.new }
        register('show')   { Handlers::Users::Operations::Show.new }
      end

      namespace('steps') do
        register('get_user') { Handlers::Users::Steps::GetUser.new }
        register('create_user') { Handlers::Users::Steps::CreateUser.new }
      end
    end
  end
end
