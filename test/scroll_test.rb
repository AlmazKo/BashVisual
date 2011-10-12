# To change this template, choose Tools | Templates
# and open the template in the editor.

$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require 'test/unit'
require 'console'
require 'scroll'

class ScrollTest < Test::Unit::TestCase
  
  def teardown
    
  end
  
  def setup
    
  end
  
  
  def test_add_check_crop_message
    mock = get_mock(Console)
    
    def mock.write_to_position(x, y, text, font = nil) 
      
      assert_equal(0, x)
      assert_equal(10-2, y)
      assert_equal(text, ("\n" << "1" * 10) * 2)
    end
    
    scroll = Scroll.new(  
      size: [10, 20],
      message_block_size: [10, 2]
    )
    
    scroll.instance_variable_set(:@console, mock)
    
    message = ("\n" << "1" * 100) * 10
    scroll.add(message)
    
  end
  
  
  def get_mock(name_object)
    mock = Object.new
    
    mock.instance_variable_set(:@test_stack, mock)
    def mock.method_missing(symbol, *args)
    
    end
    
    def mock.write_to_position(*args) 
      
      @test_stack << args
    end
     
    mock
  end
end
