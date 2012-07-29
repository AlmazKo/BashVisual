# coding: utf-8
$:.unshift(File.dirname(__FILE__))

require 'helper'


class PainterTest < Test::Unit::TestCase

  include Bash_Visual

  def setup
    @painter = Object.new
    @painter.extend(Painter)
    builder = Bash_Visual::Builder.new #mock('Bash_Visual::Builder')
    @painter.instance_variable_set(:@builder, builder)
  end

  def test_draw_window
    @painter.draw_window([1, 1], [10, 10], 'logs')
    @painter.draw_window([1, 1], [10, 10], 'logs', {font: Font.new(:bold)})
  end

  def test_draw_border
    @painter.draw_border([1, 1], [10, 10])
    @painter.draw_border([1, 1], [10, 10], {font: Font.new(:bold)})
  end

  def test_draw_filled_rectangle
    @painter.draw_filled_rectangle([1, 1], [10, 10])
    @painter.draw_filled_rectangle([1, 1], [10, 10], :red)
  end
end