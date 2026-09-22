module Services
  module Shared
    Namespace = Dry::Core::Container::Namespace.new('shared') do
      namespace('steps') do
        register('present') { Services::Shared::Steps::Present.new }
        register('validate') { Services::Shared::Steps::Validate.new }
      end

      namespace('utils') do
        register('hash_password') { Services::Shared::Utils::HashPassword.new }
      end
    end
  end
end
