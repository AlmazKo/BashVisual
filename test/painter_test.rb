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

  def test_draw_border
    @painter.draw_border([1, 1], [10, 10])
    @painter.draw_border([1, 1], [10, 10]) {{font: Font.new(:bold)}}

    scroll = VerticalScroll.new(position: [1,1], size: [1,1])
    @painter.draw_border scroll
  end

  def test_draw_filled_rectangle
    @painter.draw_filled_rectangle([1, 1], [10, 10], :white)
    @painter.draw_filled_rectangle([1, 1], [10, 10], :red) {{font: Font.new(:bold)}}

    scroll = VerticalScroll.new(position: [1,1], size: [1,1])
    @painter.draw_filled_rectangle scroll, :red
  end

  def test_draw_window_small
    assert_raise_message "width,height must be great than 2" do
      @painter.draw_window([0, 0] ,[2, 2], 'W')
    end
  end


  def test_draw_window
    scroll = VerticalScroll.new(position: [1,1], size: [1,1])

    @painter.draw_window([0, 0] ,[3, 3], 'Win!')

    @painter.draw_window(scroll, 'scroll 1')

    @painter.draw_window(scroll, 'scroll 2') do
      {border: Painter::BORDER_UTF_DOUBLE}
    end

    @painter.draw_window([0, 0] ,[4, 4], 'Win!') do
      {border: Painter::BORDER_UTF_DOUBLE, font: Font.new(:bold)}
    end

  end

end