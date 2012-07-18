$:.push File.expand_path('../../lib', __FILE__)

require 'bash-visual'
include Bash_Visual

border_font = Font.new(:std, :blue)
main_color = Font.new(:bold, :green)

console = Console.new(main_color)
console.clear

console.draw_window(2, 2, 20, 5, 'Example', border_font, Console::BORDER_UTF_DOUBLE)
console.write_to_position(5, 3, 'Hello World!')
console.position = [0, 8]