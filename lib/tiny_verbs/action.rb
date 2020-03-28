# frozen_string_literal: true

module TinyVerbs
  class Action
    # Prevent `Class.new` from being called externally
    # https://apidock.com/ruby/Module/private_class_method
    private_class_method :new

    # Action.build
    def self.build(**deps)
      # Define "default" dependencies or pass external / "override" dependencies
      # deps[:another_action] = deps[:another_action] || AnotherAction.build
      new(**deps)
    end

    # Action.call (protected, see: self.singleton_method_added)
    def self.call(**args)
      build.call(**args)
    end

    # Ruby Class Method
    # Invoked when a singleton method is added to the receiver.
    # Note: Keep this below `self.call`
    # https://apidock.com/ruby/Object/singleton_method_added
    def self.singleton_method_added(method_name)
      # Protect self.call
      if method_name == :call
        raise(TinyVerbs::Errors::ProtectedCallClassMethodError, "#{self}.call class method cannot be overriden.")
      end
    end

    # Action.build.call
    # Action.call
    def call(**args)
      raise(TinyVerbs::Errors::MissingCallMethodError, "#{self}#call instance method must be defined.")
    end

    protected

    # Action.new(...)
    def initialize(**deps)
      # TinyVerbs::Action is abstract and cannot be instatiated
      if self.class == TinyVerbs::Action
        raise(TinyVerbs::Errors::AbstractClassError, "#{self} is an abstract class and cannot be instantiated.")
      end

      apply_dependencies(deps)
    end

    # Sets dependencies to action instance
    # @some_dep = deps[:some_dep]
    def apply_dependencies(deps)
      deps.each { |name, dep| instance_variable_set("@#{name}", dep) }
    end
  end
end
