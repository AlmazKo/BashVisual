$:.unshift(File.dirname(__FILE__))

require 'helper'

class FontTest < Test::Unit::TestCase

  include Bash_Visual

  def test_inspect

    font = Font.new

    expected = '<Font type=%s, foreground=%s, background=nil>' %
        [font.type, font.foreground]

    assert_equal(expected, font.inspect)
  end

  def test_font_all
    font = Font.new([Font::UNDERLINE, Font::BOLD, Font::BLINK])

    expected = ["\e[4m\e[1m\e[5;97m", "\e[1m\e[4m\e[5;97m"]
    assert_include expected, font.to_s
  end

  def test_font_without_blink
    font = Font.new([Font::UNDERLINE, Font::BOLD])

    expected = ["\e[4m\e[1;97m", "\e[1m\e[4;97m"]
    assert_include expected, font.to_s
  end

  def test_font_underline
    font = Font.new(Font::UNDERLINE)

    assert_equal "\e[4;97m", font.to_s
  end

  def test_font_bold
    font = Font.new([Font::BOLD])

    assert_equal "\e[1;97m", font.to_s
  end

  def test_font_foreground
    font = Font.new(Font::STD, Font::CYAN)
    assert_equal "\e[0;36m", font.to_s

    font = Font.new(Font::STD, Font::LIGHT_GREEN)
    assert_equal "\e[0;92m", font.to_s
  end


  def test_font_background
    font = Font.new(Font::STD, Font::WHITE, Font::CYAN)
    assert_equal "\e[0;97;46m", font.to_s

    font = Font.new(Font::STD, Font::WHITE, Font::LIGHT_GREEN)
    assert_equal "\e[0;97;92m", font.to_s
  end


  def test_rand_color
    mock_class_method(Font, :rand, "def rand (max=0); 3; end")
    color = Bash_Visual::Font::rand_color
    assert_equal 3, color

    mock_class_method(Font, :rand, "def rand (max=0); 15; end")
    color = Bash_Visual::Font::rand_color
    assert_equal 17, color

    mock_class_method(Font, :rand, "def rand (max=0); 1; end")
    color = Bash_Visual::Font::rand_color 4
    assert_equal 1, color

    mock_class_method(Font, :rand, "def rand (max=0); 4; end")
    color = Bash_Visual::Font::rand_color 4
    assert_equal 5, color

    mock_class_method(Font, :rand, "def rand (max=0); 15; end")
    color = Bash_Visual::Font::rand_color 15
    assert_equal 0, color

  end

  protected

  def mock_class_method(class_name, method, eval_string)
    eigenclass = class << class_name
      self
    end
    eigenclass.class_eval eval_string

  end

end