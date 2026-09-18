require 'falcon/environment/rack'
require 'falcon/environment/server'

service "app" do
  include Falcon::Environment::Server
  include Falcon::Environment::Rackup
end
