# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'griddle/version'

Gem::Specification.new do |spec|
  spec.name          = "griddle"
  spec.version       = Griddle::VERSION
  spec.authors       = ["bjh"]
  spec.email         = ["fake@fake.com"]
  spec.summary       = %q{treat CSV like a grid}
  spec.description   = %q{access rectangles of data instead of rows and columns}
  spec.homepage      = "https://github.com/bjh/griddle"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "terminal-table"
  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
end
