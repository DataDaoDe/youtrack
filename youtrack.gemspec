# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'youtrack/version'

Gem::Specification.new do |spec|

  # META
  spec.name          = "youtrack"
  spec.version       = Youtrack::VERSION
  spec.authors       = ["John Faucett"]
  spec.email         = ["jwaterfaucett@gmail.com"]
  spec.description   = %q{JetBrains youTrack Rest API Client in Ruby}
  spec.summary       = %q{A Ruby REST API Client for JetBrains youTrack software}
  spec.homepage      = "http://jwaterfaucett.github.io/youtrack/"
  spec.license       = "MIT"

  # FILES
  spec.files         = `git ls-files`.split($/).grep(%r{^(?!binstubs|examples)})
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  # HARD DEPENDENCY
  spec.add_dependency "httparty"
  spec.add_dependency "multipart-post"

  # DEVELOPMENT
  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "cucumber", "~> 1.3.10"
  spec.add_development_dependency "rspec", "~> 2.14.1"
  spec.add_development_dependency "webmock", "~> 1.17.1"
  spec.add_development_dependency "vcr", "~> 2.8.0"
end
