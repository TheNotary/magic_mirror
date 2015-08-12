# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'magic_mirror/version'

Gem::Specification.new do |spec|
  spec.name          = "magic_mirror"
  spec.version       = MagicMirror::VERSION
  spec.authors       = ["TheNotary"]
  spec.email         = ["no@mail.plz"]

  spec.summary       = %q{ A library that makes it easy to add an HTML based GUI to your ruby library}
  spec.homepage      = "https://github.com/TheNotary/magic_mirror"
  spec.license       = "MIT" # uncomment this line if MIT is the best license for your situation

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]


  spec.add_dependency "sinatra", "~> 1.4"
  spec.add_dependency "faye", "~> 1.1"

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.3"
end
