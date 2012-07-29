# coding: utf-8
$:.unshift(File.dirname(__FILE__))

require 'helper'

class ScrollTest < Test::Unit::TestCase

  include Bash_Visual

  def test_empty_params

    assert_raise_message "Minimum needs: :size and :position" do
      scroll = Scroll.new :prefix => nil
    end

    assert_raise_message "Minimum needs: :size and :position" do
      scroll = Scroll.new :size => [1,1]
    end

    assert_raise_message "Minimum needs: :size and :position" do
      scroll = Scroll.new :position => [1,1]
    end
  end

  def test_rows_wrap__example

    text = 'Hello world. Lot of words...'
    expected = ['Hell', 'o wo', 'rld.', ' Lot']
    result = Scroll::form_block(text, [4,4])

    assert_equal expected, result
  end

  def test_rows_wrap__min

    text = 'Hello world. Lot of words...'
    expected = ['H']
    result = Scroll::form_block(text, [1,1])

    assert_equal expected, result
  end


  def test_rows_wrap__fill

    text = 'Hell'
    expected = ['Hell ']
    result = Scroll::form_block(text, [5, 3])

    assert_equal expected, result
  end

  def test_rows_wrap__fixate_fill

    text = 'Hell'
    expected = ['Hell ', ' ' * 5, ' ' * 5]
    result = Scroll::form_block(text, [5, 3], true)

    assert_equal expected, result
  end
end
