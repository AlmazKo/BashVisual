$:.unshift(File.dirname(__FILE__))

require 'helper'

class FontTest < Test::Unit::TestCase

  include Bash_Visual

  def test_inspect

    font = Font.new

    expected = '<Font types=%s, foreground=%s, background=nil>' %
        [font.types, font.foreground]

    assert_equal(expected, font.inspect)
  end

  def test_font_all
    font = Font.new([:underline, :bold, :blink])
    expected = ["\e[1;4;5;97m", "\e[1;5;4;97m","\e[4;1;5;97m", "\e[4;5;1;97m", "\e[5;1;4;97m", "\e[5;4;1;97m"]

    assert_include expected, font.to_s
  end

  def test_font_without_blink
    font = Font.new [:underline, :bold]

    expected = ["\e[4;1;97m", "\e[1;4;97m"]
    assert_include expected, font.to_s
  end

  def test_font_underline
    font = Font.new(:underline)

    assert_equal "\e[4;97m", font.to_s
  end

  def test_font_bold
    font = Font.new([:bold])

    assert_equal "\e[1;97m", font.to_s
  end

  def test_font_foreground
    font = Font.new(:std, :dark_cyan)
    assert_equal "\e[0;36m", font.to_s

    font = Font.new(:std, :green)
    assert_equal "\e[0;92m", font.to_s
  end


  def test_font_background
    font = Font.new(:std, :white, :dark_cyan)
    assert_equal "\e[0;97;46m", font.to_s

    font = Font.new(:std, :white, :green)
    assert_equal "\e[0;97;102m", font.to_s
  end


  def test_rand_color
    mock_class_method(Font, "def rand (max=0); 3; end")
    color = Font::rand_color
    assert_equal :dark_yellow, color

    mock_class_method(Font, "def rand (max=0); 15; end")
    color = Font::rand_color :white
    assert_not_equal(color, :white)

  end

  def test_rand
    assert_instance_of Font, Font::rand_font
  end

  def test_illegal_color
    assert_raise_message "Illegal color wrong_color" do
      font = Font.new :std, :wrong_color
    end
  end

  def test_add_type
    font = Font.new

    assert_false(font.add_type :std)

    assert_true(font.add_type :bold)
    assert_equal [:bold], font.types

    assert_true(font.add_type :underline)
    assert_equal [:bold, :underline], font.types
  end


  def test_remove_type
    font = Font.new

    assert_false(font.remove_type :std)
    assert_equal [:std], font.types

    font.add_type :underline
    assert_false(font.remove_type :std)

    assert_true(font.add_type :bold)
    font.remove_type :underline
    assert_equal [:bold], font.types

  end

  protected

  def mock_class_method(class_name, eval_string)
    eigenclass = class << class_name
      self
    end
    eigenclass.class_eval eval_string

  end

end