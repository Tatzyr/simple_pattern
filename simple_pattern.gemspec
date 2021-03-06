# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'simple_pattern/version'

Gem::Specification.new do |spec|
  spec.name          = "simple_pattern"
  spec.version       = SimplePattern::VERSION
  spec.authors       = ["Tatsuya Otsuka"]
  spec.email         = ["tatzyr@gmail.com"]

  spec.summary       = %q{Very simple and plain pattern matching library using Object#===}
  spec.homepage      = "https://github.com/Tatzyr/simple_pattern"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "simplecov"
  spec.add_development_dependency "codeclimate-test-reporter", "~> 1.0"
  spec.add_development_dependency "rake", "~> 11.3"
  spec.add_development_dependency "rspec", "~> 3.0"
end
