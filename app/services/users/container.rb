module Services
  module Users
    class Container
      extend Dry::Core::Container::Mixin
      import Services::Shared::Namespace

      namespace('operations') do
        register('create_user')  { Services::Users::Operations::CreateUser.new }
        register('get_user')     { Services::Users::Operations::GetUser.new }
        register('sign_in_user') { Services::Users::Operations::SignInUser.new }
      end

      namespace('steps') do
        register('load_user')       { Services::Users::Steps::LoadUser.new }
        register('create_user')     { Services::Users::Steps::CreateUser.new }
        register('verify_password') { Services::Users::Steps::VerifyPassword.new }
      end

      namespace('contracts') do
        register('create_user')  { Services::Users::Contracts::CreateUser.new }
        register('get_user')     { Services::Users::Contracts::GetUser.new }
        register('sign_in_user') { Services::Users::Contracts::SignInUser.new }
      end

      namespace('projections') do
        register('common')       { Services::Users::Projections::Common.new }
        register('sign_in_user') { Services::Users::Projections::SignInUser.new }
      end

      namespace('utils') do
        register('hash_password')   { Services::Users::Utils::HashPassword.new }
        register('verify_password') { Services::Users::Utils::VerifyPassword.new }
      end
    end
  end
end
