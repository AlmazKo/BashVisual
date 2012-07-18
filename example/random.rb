$:.push File.expand_path('../../lib', __FILE__)
require 'bash-visual'
include Bash_Visual

console = Console.new

'Font random demonstration'.chars do |char|
  console.write char, Font.new(:std, Font::rand_color(:black))
end