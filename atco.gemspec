# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "atco"
  s.version = "1.0.0"
  s.description = "Simple and opinionated library for parsing ATCO .cif files to JSON with Ruby"
  s.summary = "Parse ATCO .cif files to JSON with Ruby"
  s.homepage = "http://github.com/davidjrice/atco"
  s.license = "MIT"
  s.authors = ["David Rice"]
  s.email = "me@davidjrice.co.uk"
  s.files = s.files = Dir["{lib,spec}/**/*", "README.mdown", "Rakefile", "VERSION"]
  s.extra_rdoc_files = [
    "README.mdown"
  ]
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.add_development_dependency 'rspec'
end
