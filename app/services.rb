module Services
  extend Dry::Core::Container::Mixin

  register('job_apps') { Services::JobApps::Service.new }
  register('users')    { Services::Users::Service.new }
end
