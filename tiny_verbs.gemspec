# frozen_string_literal: true

require_relative "lib/tiny_verbs/version"

Gem::Specification.new do |s|
  s.name        = %q(tiny_verbs)
  s.version     = TinyVerbs::VERSION
  s.date        = %q(2020-03-28)
  s.authors     = ["Johnny Benson"]
  s.email       = ["johnnybenson@gmail.com"]
  s.homepage    = "https://github.com/johnnybenson/tiny-verbs"
  s.summary     = "TinyVerbs creates service namespaces and actions"
  s.description = "TinyVerbs keeps functionality simple, portable, and out of the models, controllers, and views."
  s.license     = "MIT"
  s.files       = Dir["lib/**/*.rb", "LICENSE", "README.md"]

  s.add_development_dependency "rspec", '~> 3.8'
  s.add_development_dependency "rubocop", '~> 0.76'
  s.add_development_dependency "rubocop-airbnb", '~> 3.0'
end
