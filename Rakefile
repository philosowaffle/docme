require 'rake/testtask'

Rake::TestTask.new do |t|
  t.libs << 'lib'
  t.pattern = 'test/**/*test_*.rb'
end

desc "Run tests"
task :default => :test