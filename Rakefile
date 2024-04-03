require "bundler/gem_tasks"

begin
  require 'rake/testtask'

  Rake::TestTask.new do |t|
    t.libs << 'test'
    t.test_files = FileList['test/**/*_test.rb']
    t.verbose = true
  end
rescue LoadError
  puts "Rake, or one of its dependencies, is not available. Install it with: sudo gem install rake"
end