require 'rake/testtask'
require 'coveralls'

Coveralls.wear!

Rake::TestTask.new do |t|
  t.libs << 'test'
end

desc "Run tests"
task :default => :test