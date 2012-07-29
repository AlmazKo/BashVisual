$:.push File.expand_path('../../lib', __FILE__)

require 'bash-visual'
include Bash_Visual

console = Console.new
console.clear

console.draw_window [3, 3], [18, 5], 'Example', {font: Font.new(:std, :red)}
console.write_to_position 5, 4, 'Hello World!', Font.new(:bold)
console.position = [0, 8]