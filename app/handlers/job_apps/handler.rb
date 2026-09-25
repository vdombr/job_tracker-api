module Handlers
  module JobApps
    class Handler
      NAMESPACE = 'operations'

      def method_missing(name, input = {}, options = {}, &block)
        key = [NAMESPACE, name].join('.')
        super unless Container.key?(key)

        Container[key].call(input, **options, &block)
      end

      def respond_to_missing?(name, include_private = false)
        key = [NAMESPACE, name].join('.')
        Container.key?(key) || super
      end
    end
  end
end
