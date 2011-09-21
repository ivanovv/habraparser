$:.push File.expand_path("../lib", __FILE__)
require "habraparser/version"

Gem::Specification.new do |s|
  s.name        = "habraparser"
  s.version     = Habr::VERSION
  s.authors     = ["blackfoks"]
  s.email       = ["mail@blackfoks.com"]
  s.homepage    = "http://github.com/blackfoks/habraparser"
  s.summary     = %q{Habrahabr ruby parser.}
  s.description = %q{Habrahabr parser is intended to get data from http://habrahabr.ru}
  
  s.rubyforge_project = "habraparser"
  
  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  
  s.add_runtime_dependency "nokogiri"
  s.add_development_dependency "rspec"
end
