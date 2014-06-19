require 'rake/testtask'
require 'rubocop/rake_task'

Rake::TestTask.new do |t|
  t.libs << 'lib'
  t.libs << 'test'
  t.pattern = 'test/**/*.rb'
end

RuboCop::RakeTask.new(:rubocop) do |task|
    task.fail_on_error = false
end

desc "Run tests"
task tests: :test

desc "Run linter"
task lint: :rubocop

task default: [:test, :rubocop]