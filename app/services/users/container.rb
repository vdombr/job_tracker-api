module Services
  module Users
    class Container
      extend Dry::Core::Container::Mixin
      import Services::Shared::Namespace

      namespace('operations') do
        register('create_user') { Services::Users::Operations::CreateUser.new }
        register('get_user')    { Services::Users::Operations::GetUser.new }
      end

      namespace('steps') do
        register('load_user')   { Services::Users::Steps::LoadUser.new }
        register('create_user') { Services::Users::Steps::CreateUser.new }
      end

      namespace('contracts') do
        register('create_user') { Services::Users::Contracts::CreateUser.new }
        register('get_user')    { Services::Users::Contracts::GetUser.new }
      end

      namespace('projections') do
        register('common')      { Services::Users::Projections::Common.new }
      end
    end
  end
end
