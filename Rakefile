require 'bundler/setup'
require 'padrino-core/cli/rake'
require 'rake/testtask'

Rake::TestTask.new do |test|
  test.pattern = 'test/**/test_*.rb'
  test.libs << 'test'
  test.verbose = true
end

desc 'Autotest'
task :guard do
  sh 'bundle exec guard'
end

desc 'Run application test suite'
task default: :test

PadrinoTasks.use(:database)
PadrinoTasks.init
