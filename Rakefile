require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'

Rake::TestTask.new do |t|
  t.test_files = FileList['test/test*.rb']
  t.verbose = true
end

Rake::RDocTask.new do |t|
  t.main = "README.rdoc"
  t.rdoc_files.include("README.rdoc", "lib/**/*.rb")
  t.rdoc_dir = "doc"
end




