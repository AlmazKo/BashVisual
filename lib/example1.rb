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

window_font = Font.new(Font::STD, Font::WHITE, Font::BLUE)
background_font = Font.new(Font::STD, Font::WHITE, Font::LIGHT_GRAY)
console.draw_rectangle(0, 31, 124, 12, background_font)
console.draw_window(0, 32, 122, 6, 'Example List', window_font, Console::BORDER_UTF_ROUND, [' ', ' '])

font_scroll = Font.new(Font::STD, Font::YELLOW)

scroll = VerticalScroll.new(
  coordinates: [41, 1],
  window_size: [80, 28],
  message_block_size: 23,
  font: font_scroll,
  separator: "\u2508",
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

 # scroll.add('' << RandomText::get() << "  \n#{x} #{y}\n1221"*2)
  font = Font.new(Font::STD, Font::rand_color(Font::BLACK), Font::BLACK)
  scroll.add(RandomText::get() << "\n 6", font)
  font = Font.new(Font::STD, window_font.foreground, window_font.background)
  scroll2.add(RandomText::get(), font)

  sleep(0.3)
}