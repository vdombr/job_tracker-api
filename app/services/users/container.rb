module Services
  module Users
    class Container
      extend Dry::Core::Container::Mixin
      import Services::Shared::Namespace

      namespace('operations') do
        register('create_user') { Services::Users::Operations::CreateUser.new }
      end

      namespace('steps') do
        register('create_user') { Services::Users::Steps::CreateUser.new }
      end

      namespace('contracts') do
        register('create_user') { Services::Users::Contracts::CreateUser.new }
      end

      namespace('projections') do
        register('common') { Services::Users::Projections::Common.new }
      end
    end
  end
end
