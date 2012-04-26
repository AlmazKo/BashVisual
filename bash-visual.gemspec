# -*- encoding: utf-8 -*-

Dir[File.dirname(__FILE__) + '/lib/bash-visual/*.rb'].each {|file| require file }

Gem::Specification.new do |gem|
  gem.name          = 'bash-visual'
  gem.author        = 'Alexander Suslov'
  gem.email         = ['a.s.suslov@gmail.com']
  gem.description   = %q{Bash visualisation tools}
  gem.summary       = %q{Bash visualisation tools}
  gem.homepage      = 'https://github.com/AlmazKo/BashConsole'

  gem.files         = `git ls-files`.split($\)
  gem.require_paths = ['lib']
  gem.version       = Bash_Visual::VERSION
  gem.license       = 'MIT'
end
