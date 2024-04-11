# frozen_string_literal: true

require_relative "lib/atco/version"

Gem::Specification.new do |s|
  s.name = "atco"
  s.version = Atco::VERSION
  s.description = "Simple and opinionated library for parsing ATCO .cif files to JSON with Ruby"
  s.summary = "Parse ATCO .cif files to JSON with Ruby"
  s.homepage = "http://github.com/davidjrice/atco"
  s.license = "MIT"
  spec.required_ruby_version = ">= 2.7.0"
  spec.authors = ["David Rice"]
  spec.email = "me@davidjrice.co.uk"
  spec.files = Dir["{lib,spec}/**/*", "README.md", "Rakefile", "VERSION"]
  spec.extra_rdoc_files = [
    "README.md"
  ]
  spec.rdoc_options = ["--charset=UTF-8"]
  spec.require_paths = ["lib"]
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
end
