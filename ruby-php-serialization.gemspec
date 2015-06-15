# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'php_serialization/version'

Gem::Specification.new do |spec|
  spec.name          = "ruby-php-serialization"
  spec.version       = Ruby::Php::Serialization::VERSION
  spec.authors       = ["Rodrigo Kochenburger"]
  spec.email         = ["divoxx@gmail.com"]
  spec.summary       = %q{Pure Ruby implementation of php's methods: serialize() and unserializer()}
  spec.description   = %q{Pure Ruby implementation of php's methods: serialize() and unserializer()}
  spec.homepage      = "https://github.com/divoxx/ruby-php-serialization"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0.0"

  spec.add_dependency "racc"
end
