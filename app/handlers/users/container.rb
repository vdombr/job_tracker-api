module Handlers
  module Users
    class Container
      extend Dry::Core::Container::Mixin
      import Handlers::Shared::Namespace

      namespace('operations') do
        register('create')  { Handlers::Users::Operations::Create.new }
        register('show')    { Handlers::Users::Operations::Show.new }
        register('sign_in') { Handlers::Users::Operations::SignIn.new }
      end

      namespace('steps') do
        register('create_user')     { Handlers::Users::Steps::CreateUser.new }
        register('create_token')    { Handlers::Users::Steps::CreateToken.new }
        register('get_user')        { Handlers::Users::Steps::GetUser.new }
        register('sign_in_user')    { Handlers::Users::Steps::SignInUser.new }
        register('respond_success') { Handlers::Users::Steps::RespondSuccess.new }
      end
    end
  end
end
