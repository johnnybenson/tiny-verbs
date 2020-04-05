# frozen_string_literal: true

module TinyVerbs
  module Generators
    module Helpers
      def service_name
        (options['service'] || '').underscore
      end

      def action_name
        (options['action'] || '').underscore
      end

      def service_class
        service_name.camelize
      end

      def service_path
        "app/services/#{service_name}_service"
      end

      def service_spec_path
        "spec/services/#{service_name}_service"
      end

      def action_class
        action_name.camelize
      end

      def action_path
        "#{service_path}/#{action_name}.rb"
      end

      def action_spec_path
        "#{service_spec_path}/#{action_name}_spec.rb"
      end
    end
  end
end
