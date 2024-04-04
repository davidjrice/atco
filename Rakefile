# frozen_string_literal: true

require 'bundler/gem_tasks'
require 'rspec/core/rake_task'

begin
  RSpec::Core::RakeTask.new(:spec)
rescue LoadError
  puts 'RSpec, or one of its dependencies, is not available. Install it with: bundle install'
end

task default: :spec
