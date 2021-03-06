# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'tablecloth/version'

Gem::Specification.new do |spec|
  spec.name          = "tablecloth"
  spec.version       = Tablecloth::VERSION
  spec.authors       = ["Tim Cooper"]
  spec.email         = ["coop@latrobest.com"]

  spec.summary       = "DRY-er cucumber tables"
  spec.description   = spec.summary
  spec.homepage      = "https://github.com/coop/tablecloth"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "transproc"

  spec.add_development_dependency "bundler", "~> 1.9"
  spec.add_development_dependency "cucumber"
  spec.add_development_dependency "money"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
end
