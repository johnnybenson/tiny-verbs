# frozen_string_literal: true

require 'rails/generators'

module TinyVerbs
  module Generators
    class ActionGenerator < Rails::Generators::Base
      class_option :service, type: :string
      class_option :action, type: :string

      # Usage
      # > rails generate tiny_verbs:action --service pizza --action party
      def generate
        raise "Must create service namespace first, see: rails generate tiny_verbs" if !File.exist?(service_path)
        raise "Action exists, see: #{action_path}" if File.exist?(action_path)

        create_service_action_file
      end

      protected

      def service_name
        options['service']
      end

      def action_name
        options['action']
      end

      def service_class
        service_name.camelize
      end

      def service_path
        "app/services/#{service_name.underscore}_service"
      end

      def action_class
        action_name.camelize
      end

      def action_path
        "#{service_path}/#{action_name.underscore}"
      end

      def create_service_action_file
        create_file "#{action_path}.rb", <<-FILE
# frozen_string_literal: true

class #{service_class}Service::#{action_class} < TinyVerbs::Action
  def call
  end
end
FILE
      end
    end
  end
end
