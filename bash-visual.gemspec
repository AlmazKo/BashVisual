# coding: utf-8
$:.push File.expand_path('../lib', __FILE__)
require 'bash-visual/version'


Gem::Specification.new do |gem|
  gem.name          = 'bash-visual'
  gem.author        = 'Alexander Suslov'
  gem.email         = ['a.s.suslov@gmail.com']
  gem.description   = %q{Bash visualisation tools}
  gem.summary       = gem.description
  gem.homepage      = 'https://github.com/AlmazKo/BashVisual'

  gem.files         = `git ls-files`.split($\)
  gem.test_files    = `git ls-files -- {test}/*`.split($\)
  gem.require_paths = ['lib']
  gem.version       = Bash_Visual::VERSION
  gem.license       = 'MIT'
end
