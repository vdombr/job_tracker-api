module Handlers
  extend Dry::Core::Container::Mixin
  register('users') { Handlers::Users::Handler.new }
end
