module Handlers
  module Shared
    Namespace = Dry::Core::Container::Namespace.new('shared') do
      namespace('steps') do
      end

      namespace('utils') do
      end
    end
  end
end
