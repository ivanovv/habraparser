spec = Gem::Specification.new do |s|
  
  # about
  s.name = 'habraparser'
  s.version = '0.0.2'
  s.summary = 'Habrahabr ruby parser.'
  s.description = %{Habrahabr parser is intended to get data from http://habrahabr.ru}
  
  # gem files
  s.files = ['README.md', 'lib/habraparser.rb', 'lib/user.rb']
  
  # rdoc status
  s.has_rdoc = true
  
  # author
  s.author = 'blackfoks'
  s.email = 'mail@blackfoks.com'
  
  # gem homepage
  s.homepage = 'http://github.com/blackfoks/habraparser'
  
  # dependencies
  s.add_dependency('nokogiri', '>= 1.5.0')
  s.add_development_dependency('rspec')
  
end
