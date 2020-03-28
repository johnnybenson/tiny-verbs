# TinyVerbs 🍕

A Ruby Service/Action Gem

## TinyVerbs::Action

A simple class for composing service level actions as portable tiny verbs!

### Building an action

```rb
# Simple action
class PizzaService::ScheduleDelivery < TinyVerbs::Action
  def call(keyword:, ...)
    ...
  end
end

# Action with a dependency
class PizzaService::ScheduleDelivery < TinyVerbs::Action
  # apply default dependencies in self.build
  def self.build(**args)
    args[:assign_driver] ||= DriverService::Assign.build
    new(**args)
  end

  def call(keyword:, ...)
    @assign_driver.call
  end
end
```

### Using an action

```rb
# Call with built-in dependences
PizzaService.call

# Call with passed dependences
PizzaService.build(...deps...).call

# Build with passed dependencies and call it later
instance = PizzaService.build(...deps...)
instance.call
```

## TinyVerbs::Errors

A place to store error classes namespaced to the service

```rb
module PizzaService::Errors
  class LateDeliveryError < StandardError; end
end
```

## TinyVerbs::Helpers

A place to store shared functionality

```rb
module PizzaService::Helpers
  def extra_cheese_amount
    "a lot"
  end
end

PizzaService.extra_cheese_amount
```

## TinyVerbs File Structure

```sh
app/services

# Service Namespace
app/services/pizza_service.rb

# Service Actions
app/services/pizza_service/
app/services/pizza_service/slap_dough.rb
app/services/pizza_service/apply_topping.rb
app/services/pizza_service/schedule_delivery.rb
app/services/pizza_service/enjoy_it.rb

# Service Errors
app/services/pizza_service/errors.rb

# Service Helpers
app/services/pizza_service/helpers.rb
```

## Generators

Generate a new service namespace (includes errors and helpers)

```sh
> rails generate tiny_verbs:service --service pizza
```

Generate a new service action

```sh
> rails generate tiny_verbs:action --service pizza --action schedule_delivery
```
