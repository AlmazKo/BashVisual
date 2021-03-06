# coding: utf-8
$:.push File.expand_path('../../lib', __FILE__)
require 'bash-visual'
include Bash_Visual

console = Console.new
console.clear

v_scroll = VerticalScroll.new(
  position: [33, 1],
  size: [39, 9],
  prefix: ->{Time.now.strftime('%H-%M-%S:%3N') + ' '}
)

h_scroll = HorizontalScroll.new(
    position: [2, 12],
    size: [70, 4],
    fixed_message_block_size: 20,
    separator: true
)

console.draw_window(v_scroll, 'Vertical scroll')
console.draw_window(h_scroll, 'Horizontal scroll')

phrases =[
    "Bash is a Unix shell",
    "GNU’s Not UNIX",
    "Answer to the Ultimate Question of Life, the Universe, and Everything"]


Thread.new {
  10.times do
    h_scroll.add phrases.sample
    sleep 0.3
  end
}
Thread.new {
  10.times do
    v_scroll.add phrases.sample
    sleep 0.15
  end
}

sleep 4
console.position = [1,18]