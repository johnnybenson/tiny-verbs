# frozen_string_literal: true

require 'rails/generators'

module TinyVerbs
  module Generators
    class ServiceGenerator < Rails::Generators::Base
      class_option :service, type: :string

      # Usage
      # > rails generate tiny_verbs:service --service pizza
      def generate
        raise "Service exists, see: #{service_path}" if File.exist?(service_path)

        if !File.exist?(service_path)
          create_service_directory
          create_service_errors_module
          create_service_helpers_module
          create_service_module
        end
      end

      protected

      def service_name
        options['service']
      end

      def service_class
        service_name.camelize
      end

      def service_path
        "app/services/#{service_name.underscore}_service"
      end

      def create_service_directory
        empty_directory service_path
      end

      def create_service_errors_module
        create_file "#{service_path}/errors.rb", <<-FILE
# frozen_string_literal: true

module #{service_class}Service::Errors
end
FILE
      end

      def create_service_helpers_module
        create_file "#{service_path}/helpers.rb", <<-FILE
# frozen_string_literal: true

module #{service_class}Service::Helpers
end
FILE
      end

      def create_service_module
        create_file "#{service_path}.rb", <<-FILE
# frozen_string_literal: true

module #{service_class}Service
  extend #{service_class}Service::Helpers
end
FILE
      end
    end
  end
end
