# coding: utf-8
$:.unshift(File.dirname(__FILE__))

require 'helper'

class ScrollTest < Test::Unit::TestCase

  include Bash_Visual

  def test_empty_params

    assert_raise_message "Minimum needs: :window_size and :coordinates" do
      scroll = Scroll.new :prefix => nil
    end

    assert_raise_message "Minimum needs: :window_size and :coordinates" do
      scroll = Scroll.new :coordinates => [1,1]
    end

    assert_raise_message "Minimum needs: :window_size and :coordinates" do
      scroll = Scroll.new :window_size => [1,1]
    end
  end

end