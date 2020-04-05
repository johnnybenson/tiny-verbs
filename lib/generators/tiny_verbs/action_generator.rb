# frozen_string_literal: true

require 'rails/generators'
require_relative './helpers'

module TinyVerbs
  module Generators
    class ActionGenerator < Rails::Generators::Base
      prepend TinyVerbs::Generators::Helpers

      source_root File.expand_path('templates', __dir__)

      class_option :service, type: :string
      class_option :action, type: :string

      # Usage
      # > rails generate tiny_verbs:action --service pizza --action party
      def generate

        @action_class = action_class
        @service_class = service_class

        template "action.erb", action_path
        template "action_spec.erb", action_spec_path
      end
    end
  end
end
