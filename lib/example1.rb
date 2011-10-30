# coding: utf-8
$:.unshift(File.dirname(__FILE__))

require 'bash/console'
require 'bash/font'
require 'scroll'
require 'vertical_scroll'
require 'horizontal_scroll'
require 'common/random_text'

default_font = Font.new(Font::STD, Font::LIGHT_BLUE)


console = Console.new(default_font)
console.clear()

font_scroll = Font.new(Font::STD, Font::YELLOW, Font::BLACK)

scroll = VerticalScroll.new(
  coordinates: [41, 1],
  window_size: [80, 30],
  message_block_size: 3,
  font: font_scroll,
  separator: "\u2500",
  start: Scroll::ENDING,
  adapt_size_message: false,
  prefix: ->{ Time.now.strftime('%H-%M-%S:%3N') << " " }
)
scroll2 = HorizontalScroll.new(
  coordinates: [1, 32],
  window_size: [120, 4],
  message_block_size: 10,
  font: font_scroll,
  separator: true,
  start: Scroll::BEGINNING,
  adapt_size_message: false
)
  
10000.times {
  font = Font.new(Font::BOLD, rand(7), nil)
  x = rand(40)
  y = rand(30)
  console.write_to_position(x, y, '.', font)

  #scroll.add('' << RandomText::get() << "  \n#{x} #{y}\n1221"*2)
  font = Font.new(Font::STD, Font::rand_color(font_scroll.background))
  scroll.add(RandomText::get() << "\n 6", font)
  scroll2.add(RandomText::get(), font)

  sleep(0.3)
}