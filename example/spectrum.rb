$:.push File.expand_path('../../lib', __FILE__)

require 'bash-visual'
include Bash_Visual

colors = Font::COLORS
types  = [:std, :bold, :underline, :blink,
          [:bold, :underline], [:bold, :blink], [:underline, :BLINK],
          [:bold, :underline, :blink]
]

console = Console.new
console.clear

console.write 'Example: '

'Spectrum'.chars do |char|
  console.write char, Font.new(:bold, Font::rand_color)
end

console.position = [0, 2]

types.each do |type|
  colors.each do |color|
    console.write('X', Font.new(type, color))
  end
  console.move_position(-colors.size, 1)
end

console.position = [20, 2]

types.each do |type|
  colors.each do |color|
    console.write('X', Font.new(type, :white, color))
  end
  console.move_position(-colors.size, 1)
end
console.write_ln('')

