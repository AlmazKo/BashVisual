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

font_scroll = Font.new(Font::STD, Font::YELLOW, Font::BLACK)

font_scroll1 = Font.new(Font::STD, Font::LIGHT_GREEN, Font::BLACK)


scroll = Scroll.new(
  coordinates: [100, 3],
  size: [80, 20],
  message_block_size: [80, 3],
  message_crop?: true,
  message_keep: 0,
  type: Scroll::VERTICAL,
  font: font_scroll,
  separator: ' ',
  start: Scroll::BEGINNING
 # prefix: ->{ Time.now.strftime('%H-%M-%S:%3N') << "\n" }
)

at_exit do |unusedlocal|  
  #console.clear()
end  

#Thread.new { 
#  
#  scroll.add(gets())
#}

generator = ->(count){
  value = ''
  25.times {value  << (65 + rand(25)).chr}
  value
  }
  
100000.times {
  font = Font.new(Font::BOLD, rand(7), nil)
  x = rand(100)
  y = rand(40)
  console.write_to_position(x, y, '.', font)
#  
#scroll.add("\n01234" * 4, font_scroll2)

  #scroll.add(generator.(50).to_s, font_scroll1)
  
  scroll.add('' << '[]' * rand(40) << "\n1111\n1221")

  sleep(0.4)
}