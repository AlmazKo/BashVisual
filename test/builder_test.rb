# coding: utf-8
$:.unshift(File.dirname(__FILE__))

require 'helper'

class BuilderTest < Test::Unit::TestCase

  def test_clear
    font_mock = Bash_Visual::Font.new
    font_mock.to_bash {'X'}

    builder = Bash_Visual::Builder.new(font_mock)

    result = builder.clear
    assert_equal("\e[0;0H\e[2J", result)
  end

end