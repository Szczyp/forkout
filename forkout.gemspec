Gem::Specification.new do |s|
  s.name = 'forkout'
  s.version = '0.0.1'
  s.has_rdoc = false
  s.extra_rdoc_files = ['README', 'LICENSE']
  s.summary = 'forks a block'
  s.description = 'forks a list to a block using Rinda, kinda unstable'
  s.author = 'Szczyp'
  s.email = 'qboos@wp.pl'
  s.homepage = 'http://github.com/Szczyp/forkout'
  s.files = %w(LICENSE README Rakefile) + Dir.glob("{bin,lib,spec}/**/*")
  s.require_path = "lib"
  s.files = Dir["{lib, test}/**/*", "[A-Z]*"]
  s.platform = Gem::Platform::RUBY
end