# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'youtrack/version'

Gem::Specification.new do |spec|
  spec.name          = "youtrack"
  spec.version       = Youtrack::VERSION
  spec.authors       = ["John Faucett"]
  spec.email         = ["jwaterfaucett@gmail.com"]
  spec.description   = %q{JetBrains youTrack Rest API Client in Ruby}
  spec.summary       = %q{A Ruby REST API Client for JetBrains youTrack software}
  spec.homepage      = "http://jwaterfaucett.github.io/youtrack/"
  spec.license       = "GPLv3"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  # HARD DEPENDENCY
  spec.add_dependency "httparty", "~> 0.12.0"
  spec.add_dependency "multipart-post", "~> 2.0.0"

  # DEVELOPMENT
  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "cucumber", "~> 1.3.10"
  spec.add_development_dependency "rspec", "~> 2.14.1"
  spec.add_development_dependency "webmock", "~> 1.17.1"
end
