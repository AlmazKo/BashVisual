$:.push File.expand_path('../../lib', __FILE__)

require 'bash-visual'
include Bash_Visual

console = Console.new
console.clear
Thread.new {
  100.times {
    x, y          = 0, 0
    width, height = 20, 12
    5.times {
      x, y          = x+1, y+1
      width, height = width-2, height-2
      console.draw_border([x, y], [width, height], {font: Font::rand_font})
      sleep 0.08
    }
  }
}

Thread.new {
  100.times {
    x, y          = 22, 0
    width, height = 20, 12
    5.times {
      x, y          = x+1, y+1
      width, height = width-2, height-2
      console.draw_filled_rectangle([x, y], [width, height], Font::rand_color(:black))
      sleep 0.09
    }
  }

}

sleep 10
console.position = [0, 12]