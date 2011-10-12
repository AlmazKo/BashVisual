# coding: utf-8
$:.unshift(File.dirname(__FILE__))

require 'bash/console'
require 'bash/font'
require 'scroll'
require 'common/random_text'

default_font = Font.new(Font::STD, Font::LIGHT_BLUE)


console = Console.new(default_font)
console.clear()

font_scroll = Font.new(Font::STD, Font::YELLOW, Font::BLACK)

scroll = Scroll.new(
  coordinates: [41, 4],
  size: [50, 30],
  message_block_size: [50, 5],
  message_crop?: false,
  message_keep: 0,
  type: Scroll::VERTICAL,
  font: font_scroll,
  separator: '-',
  start: Scroll::ENDING,
  prefix: ->{ Time.now.strftime('%H-%M-%S:%3N') << "\n" }
)
  
100.times {
  font = Font.new(Font::BOLD, rand(7), nil)
  x = rand(40)
  y = rand(40)
  console.write_to_position(x, y, '.', font)

  scroll.add('' << RandomText::get() << "  \n#{x} #{y}\n1221"*2)

  sleep(0.3)
}