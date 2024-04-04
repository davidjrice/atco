# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "atco"
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["David Rice"]
  s.date = "2024-04-03"
  s.description = "Simple and opinionated library for parsing ATCO-CIF files with Ruby."
  s.email = "me@davidjrice.co.uk"
  s.extra_rdoc_files = [
    "README.mdown"
  ]
  s.files = [
    "README.mdown",
     "Rakefile",
     "VERSION",
     "lib/atco.rb",
     "lib/atco/journey.rb",
     "lib/atco/location.rb",
     "lib/atco/stop.rb"
  ]
  s.homepage = "http://github.com/davidjrice/atco"
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = "3.5.3"
  s.summary = "Simple and opinionated library for parsing ATCO-CIF files with Ruby."
  s.test_files = [
    "spec/atco_spec.rb",
    "spec/spec_helper.rb"
  ]
  s.add_development_dependency 'rspec'
end
