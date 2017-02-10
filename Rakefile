begin
  require 'bundler/setup'
rescue LoadError
  puts 'You must `gem install bundler` and `bundle install` to run rake tasks'
end

require 'rdoc/task'

RDoc::Task.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'SpecialSauce'
  rdoc.options << '--line-numbers'
  rdoc.rdoc_files.include('README.md')
  rdoc.rdoc_files.include('lib/**/*.rb')
end






require 'bundler/gem_tasks'

require 'rake/testtask'

Rake::TestTask.new(:test) do |t|
  t.libs << 'lib'
  t.libs << 'test'
  t.pattern = 'test/*_test.rb'
  t.verbose = false
end

Rake::TestTask.new(:watir_test) do |t|
  t.libs << 'lib'
  t.libs << 'test'
  t.pattern = 'test/sauce/watir_test.rb'
  t.verbose = false
end

Rake::TestTask.new(:capybara_test) do |t|
  t.libs << 'lib'
  t.libs << 'test'
  t.pattern = 'test/sauce/capybara_test.rb'
  t.verbose = false
end

task default: :test
