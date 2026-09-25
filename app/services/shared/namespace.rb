module Services
  module Shared
    Namespace = Dry::Core::Container::Namespace.new('shared') do
      namespace('steps') do
        register('paginate') { Services::Shared::Steps::Paginate.new }
        register('present')  { Services::Shared::Steps::Present.new }
        register('validate') { Services::Shared::Steps::Validate.new }
      end

      namespace('utils') do
      end
    end
  end
end
