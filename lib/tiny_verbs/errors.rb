# frozen_string_literal: true

module TinyVerbs
  module Errors
    class MissingCallMethodError < StandardError; end
    class ProtectedCallClassMethodError < StandardError; end
    class AbstractClassError < StandardError; end
  end
end
