require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gemspec|
    gemspec.name     = "batfish"
    gemspec.summary  = "Just a bunch of functions."
    gemspec.email    = "me@renaudbourassa.com"
    gemspec.homepage = "http://github.com/renaudb/batfish"
    gemspec.authors  = ["Renaud Bourassa"]
  end
rescue LoadError
  puts "Jeweler not available. Install it with: sudo gem install technicalpickles-jeweler -s http://gems.github.com"
end

Rake::TestTask.new do |t|
  t.test_files = FileList['test/test*.rb']
  t.verbose = true
end

Rake::RDocTask.new do |t|
  t.main = "README.rdoc"
  t.rdoc_files.include("README.rdoc", "lib/**/*.rb")
  t.rdoc_dir = "doc"
end




