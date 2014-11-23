# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'tmdb-api/version'

Gem::Specification.new do |spec|
  spec.name          = "tmdb-api"
  spec.version       = TMDb::VERSION
  spec.authors       = ["Andriel Nuernberg"]
  spec.email         = ["andrielfn@gmail.com"]
  spec.description   = "The Movie Database API v3"
  spec.summary       = "The Mobie Database API v3"
  spec.homepage      = "https://github.com/andrielfn/tmdb-api"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "httparty", "~> 0.13.0"
  spec.add_dependency "activesupport", "~> 4.1.8"

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", "~> 3.1.0"
  spec.add_development_dependency "webmock"
  spec.add_development_dependency "pry"
end
