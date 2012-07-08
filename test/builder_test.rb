# coding: utf-8
$:.unshift(File.dirname(__FILE__))

require 'helper'
#require 'lib/bash-visual/builder'
#require 'lib/bash-visual/font'

class BuilderTest < Test::Unit::TestCase

  # Called before every test method runs. Can be used
  # to set up fixture information.
  def setup
    # Do nothing
  end

  # Called after every test method runs. Can be used to tear
  # down fixture information.

  def teardown
    # Do nothing
  end


  def test_clear

    font_mock = Bash_Visual::Font.new
    font_mock.to_bash {'X'}

    builder = Bash_Visual::Builder.new(font_mock)

    result = builder.clear
    assert_equal("\e[0;0H\e[2J", result)

  end
end