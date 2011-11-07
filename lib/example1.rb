# coding: utf-8
$:.unshift(File.dirname(__FILE__))

require 'bash/console'
require 'bash/font'
require 'scroll'
require 'vertical_scroll'
require 'horizontal_scroll'
require 'common/random_text'


def join_all
  main = Thread.main
  current = Thread.current
  all = Thread.list
  all.each {|t| t.join unless t == current or t == main}
end

default_font = Font.new(Font::STD, Font::LIGHT_BLUE)


console = Console.new(default_font)
console.clear()

window_font = Font.new(Font::STD, Font::WHITE, Font::BLUE)


font_scroll = Font.new(Font::STD, Font::YELLOW)

scroll = VerticalScroll.new(
  coordinates: [41, 1],
  window_size: [80, 28],
  message_block_size: 23,
  font: font_scroll,
  separator: "\u2508",
  start: Scroll::ENDING,
  adapt_size_message: true,
  prefix: ->{ Time.now.strftime('%H-%M-%S:%3N') << " " }
)


console.draw_window(4, 31, 122, 6, 'Example List', window_font, Console::BORDER_UTF_DOUBLE)

scroll2 = HorizontalScroll.new(
  coordinates: [4, 31],
  window_size: [120, 4],
  message_block_size: 10,
  font: font_scroll,
  separator: true,
  start: Scroll::BEGINNING
)

1.upto(28) { |y| 
  if (10..20).include? y
    console.write_to_position(121, y, "\u2503")
  else
    console.write_to_position(121, y, "\u2502")
  end
  
}

Thread.new do
  1000.times do
    font = Font.new(Font::BOLD, rand(7), nil)
    x = rand(40)
    y = rand(30)
    console.write_to_position(x, y, '.', font)

    font = Font.new(Font::STD, Font::rand_color(window_font.background), window_font.background)
    scroll.add(RandomText::get(), font)
    scroll2.add(RandomText::get(), font)

    sleep(0.7)
  end
end
Thread.new do
  1000.times do
    font = Font.new(Font::STD, window_font.foreground, window_font.background)
    scroll2.add(RandomText::get(), font)

    sleep(0.3)
  end
end


join_all