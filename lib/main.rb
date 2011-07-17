# coding: utf-8
$:.unshift(File.dirname(__FILE__))

require 'console'
require 'font'
require 'scroll'

font = Font.new(Font::STD, Font::LIGHT_BLUE)

#
console = Console.new(font)
console.clear()
#console.write_ln('+' << '-' * 59 << '+')
#console.write_ln(("| %9s " % 'Thread') * 5 << '|')
#console.write_ln('+' << '-' * 59 << '+')

#####console.draw_rectangle(1, 1, 100, 40, Font::get(Font::STD, Font::STD, nil))

font_scroll = Font.new(Font::STD, Font::YELLOW, Font::BLUE)


scroll = Scroll.new(
  coordinates: [100, 3],
  size: [40, 10],
  message_block_size: [19, 3],
  message_crop?: true,
  message_keep: 0,
  type: Scroll::VERTICAL,
  font: font_scroll,
  separator?: true,
  prefix: ->{ Time.now.strftime('%H-%M-%S:%3N') << "\n" }
)

at_exit do |unusedlocal|  
  #console.clear()
end  

#Thread.new { 
#  
#  scroll.add(gets())
#}
100000.times {
  font = Font.new(Font::BOLD, rand(7), nil)
  x = rand(100)
  y = rand(40)
  console.write_to_position(x, y, '.', font)
#  
  scroll.add(('%3s %3s' % [x,  y]) << "\n///" * 4)
  #scroll.add(rand(100).to_s << 'Vx' * 20 << "\n1111\n22282\n3333!")

  sleep(0.5)
}