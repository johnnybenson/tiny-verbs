# frozen_string_literal: true

require 'rails/generators'
require_relative './helpers'

module TinyVerbs
  module Generators
    class ServiceGenerator < Rails::Generators::Base
      prepend TinyVerbs::Generators::Helpers

      source_root File.expand_path('templates', __dir__)

      class_option :service, type: :string

      # Usage
      # > rails generate tiny_verbs:service --service pizza
      def generate

        @action_class = action_class
        @service_class = service_class

        empty_directory service_path

        template "errors.erb", "#{service_path}/errors.rb"
        template "helpers.erb", "#{service_path}/helpers.rb"
        template "service.erb", "#{service_path}.rb"
      end
    end
  end
end
