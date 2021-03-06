# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{batfish}
  s.version = "0.1.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Renaud Bourassa"]
  s.date = %q{2009-09-23}
  s.email = %q{me@renaudbourassa.com}
  s.extra_rdoc_files = [
     "README.rdoc"
  ]
  s.files = [
     "README.rdoc",
     "Rakefile",
     "batfish.gemspec",
     "lib/batfish.rb",
     "lib/data/bktree.rb",
     "lib/data/linkedlist.rb",
     "lib/data/queue.rb",
     "lib/data/stack.rb",
     "lib/data/trie.rb",
     "test/helper.rb",
     "test/test_bktree.rb",
     "test/test_linkedlist.rb",
     "test/test_queue.rb",
     "test/test_stack.rb",
     "test/test_trie.rb"
  ]
  s.homepage = %q{http://github.com/renaudb/batfish}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.3}
  s.summary = %q{Just a bunch of functions.}
  s.test_files = [
     "test/helper.rb",
     "test/test_bktree.rb",
     "test/test_linkedlist.rb",
     "test/test_queue.rb",
     "test/test_stack.rb",
     "test/test_trie.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
