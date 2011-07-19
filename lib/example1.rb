# coding: utf-8
$:.unshift(File.dirname(__FILE__))

require 'console'
require 'font'
require 'scroll'

default_font = Font.new(Font::STD, Font::LIGHT_BLUE)


console = Console.new(default_font)
console.clear()

font_scroll = Font.new(Font::STD, Font::YELLOW, Font::BLACK)

scroll = Scroll.new(
  coordinates: [41, 4],
  size: [30, 30],
  message_block_size: [30, 3],
  message_crop?: true,
  message_keep: 0,
  type: Scroll::VERTICAL,
  font: font_scroll,
  separator: false,
  start: Scroll::ENDING,
  prefix: ->{ Time.now.strftime('%H-%M-%S:%3N') << "\n" }
)
  
100.times {
  font = Font.new(Font::BOLD, rand(7), nil)
  x = rand(40)
  y = rand(40)
  console.write_to_position(x, y, '.', font)

  scroll.add('' << '*' * rand(20) << "\n#{x} #{y}\n1221")

  sleep(0.1)
}