$:.push File.expand_path('../../lib', __FILE__)

require 'bash-visual'
include Bash_Visual

colors = Font::COLORS
types  = [:std, :bold, :underline, :blink,
          [:bold, :underline], [:bold, :blink], [:underline, :blink],
          [:bold, :underline, :blink]
]

console = Console.new
console.clear

console.write_ln 'Example "Spectrum":'

types.each do |type|

  colors.each do |color|
    console.write('X', Font.new(type, color))
  end

  console.write ' '

  colors.each do |color|
    console.write('X', Font.new(type, :white, color))
  end

  console.write_ln ' ' + type.inspect
end
