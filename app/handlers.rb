module Handlers
  extend Dry::Core::Container::Mixin

  register('job_apps') { Handlers::JobApps::Handler.new }
  register('users')    { Handlers::Users::Handler.new }
end
