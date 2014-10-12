# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'financier/version'

Gem::Specification.new do |spec|
  spec.name          = "financier"
  spec.version       = Financier::VERSION
  spec.authors       = ["C. Jason Harrelson"]
  spec.email         = ["jason@lookforwardenterprises.com"]
  spec.summary       = %q{Tools for personal financial analysis.}
  spec.description   = %q{Tools for personal financial analysis.  See rEADME for more details.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "pry-debugger"
  spec.add_development_dependency "rake"

  spec.add_dependency "acclimate"
  spec.add_dependency "activerecord"
  spec.add_dependency "hashie"
  spec.add_dependency "qiflib"
  spec.add_dependency "rainbow"
  spec.add_dependency "thor"
end
