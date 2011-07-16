# coding: utf-8
$:.unshift(File.dirname(__FILE__))

require 'console'
require 'font'
require 'scroll'

font = Font::get(Font::STD, Font::LIGHT_BLUE, nil)

#
console = Console.new(font)
console.clear()
#console.write_ln('+' << '-' * 59 << '+')
#console.write_ln(("| %9s " % 'Thread') * 5 << '|')
#console.write_ln('+' << '-' * 59 << '+')

console.draw_rectangle(1, 1, 100, 40, Font::get(Font::STD, Font::STD, nil))

font_scroll = Font::get(Font::STD, Font::LIGHT_GREEN, Font::BLUE)


scroll = Scroll.new(
area_width: 10,
area_height: 10,
size: 10,
x: 10,
y: 10,
type: Scroll::VERTICAL,
font: font_scroll,
time_pattern_prefix: '%H-%M-%S:%3N'
)

at_exit do |unusedlocal|  
  console.clear()
end  

#Thread.new { 
#  
#  scroll.add(gets())
#}
120000.times {
  font = Font::get(Font::BOLD, rand(7), nil)
  x = rand(100)
  y = rand(40)
  console.write_to_position(x, y, '.', font)
  scroll.add('%3s %3s' % [x,  y])

  sleep(0.05)
}