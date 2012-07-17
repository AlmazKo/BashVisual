$:.push File.expand_path('../../lib', __FILE__)

puts File.dirname(__FILE__)
puts ($:).inspect
#
require 'bash-visual'
#
#
include Bash_Visual

colors = [Font::BLACK, Font::RED, Font::GREEN, Font::BROWN, Font::BLUE, Font::MAGENTA, Font::CYAN, Font::LIGHT_GRAY, Font::GRAY,
          Font::LIGHT_RED, Font::LIGHT_GREEN, Font::YELLOW, Font::LIGHT_BLUE, Font::LIGHT_MAGENTA, Font::LIGHT_CYAN, Font::WHITE]

types = [Font::STD, Font::BOLD, Font::UNDERLINE, Font::BLINK,
         [Font::BOLD, Font::UNDERLINE], [Font::BOLD, Font::BLINK], [Font::UNDERLINE, Font::BLINK],
         [Font::BOLD, Font::UNDERLINE, Font::BLINK]]

console = Console.new
console.clear
console.write_ln 'Example N2', Font.new([Font::BOLD, Font::UNDERLINE], Font::BLACK, Font::WHITE)
types.each do |type|
  colors.each do |color|
    console.write('X', Font.new(type, color))
  end
  console.move_position(-colors.size, 1)
end

console.position = [20, 2]

types.each do |type|
  colors.each do |color|
    console.write('X', Font.new(type, Font::WHITE, color))
  end
  console.move_position(-colors.size, 1)
end
console.write_ln('')

