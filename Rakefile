# frozen_string_literal: true

require "bundler/gem_tasks"

begin
  require "rspec/core/rake_task"
  RSpec::Core::RakeTask.new(:spec)
rescue LoadError
  puts "RSpec, or one of its dependencies, is not available. Install it with: bundle install"
end

begin
  require "rubocop/rake_task"
  RuboCop::RakeTask.new
rescue LoadError
  puts "rubocop, or one of its dependencies, is not available. Install it with: bundle install"
end

task default: %i[spec rubocop]
