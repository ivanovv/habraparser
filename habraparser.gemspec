spec = Gem::Specification.new do |s|
  
  # about
  s.name = 'habraparser'
  s.version = '0.0.1'
  s.summary = 'Habrahabr ruby parser.'
  s.description = %{Habrahabr parser is intended to get data from http://habrahabr.ru}
  
  # gem files
  s.files = ['README']
  
  # requiring
  s.require_path = 'lib'
  s.autorequire = 'habr'
  
  # rdoc status
  s.has_rdoc = true
  
  # author
  s.author = 'blackfoks'
  s.email = 'mail@blackfoks.com'
  
  # gem homepage
  s.homepage = 'http://github.com/blackfoks/habraparser'
  
  # dependencies
  s.add_dependency('nokogiri', '>= 1.5.0')
  
end
