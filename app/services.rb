module Services
  extend Dry::Core::Container::Mixin
  register('users') { Services::Users::Service.new }
end
