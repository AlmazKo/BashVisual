$:.unshift(File.dirname(__FILE__))
require 'font'

class Console
  @@mutex = Mutex.new
  @@default_font = Font.new
  
  attr_reader :current_x, :current_y, :font; 
  
  def initialize (font = @@default_font)
    @current_x = 0
    @current_y = 0
    @font = font
  end
  
  def position= (x, y)
    @current_x , @current_y = x, y
    print self.set_position(x, y)
  end
  
  def move_position(offset_x, offset_y)
    @current_x += offset_x
    @current_y += offset_y
    print Builder.move_position(offset_x, offset_y)
  end
  
  # Записать что-то в определенной позиции, а потом вернуться на текущую
  # Если необходимо сохранить позицию после записи - используйте связку 
  # move_position/position= и write
  def write_to_position (x, y, text, font = @font)
    print Builder.write_to_position(x, y, text, font)
  end
  
  def write (text, font = @font) 
    print Builder.write(text, font) 
  end

  def write_ln (text, font = @font) 
    print Builder.write_ln(text, font) 
  end

  def erase_to_end_line
    print Builder.erase_to_end_line
  end
  
  def draw_rectangle(x, y, width, height, font = nil, border = nil)
    bash = ''
    bash << Builder.save_position()
    bash << Builder.set_position(x,y)
    height.times do
      bash << Builder.write(' ' * width, font)
      bash << Builder.move_position(-width, 1)
    end
    bash << Builder.restore_position()
    bash
  end
  
  # Clear the screen and move to (0,0)
  def clear 
    print Builder.clear
  end

  def font=(font)
    @font = font
  end
  
  def print string
    @@mutex.synchronize {
      super
    }
  end
  
  class Builder  
    class << self
      def restore_position
        "\e[u"
      end
    
      def save_position
        "\e[s"
      end
    
      def set_position (x, y)
        "\e[#{y.to_i};#{x.to_i}H"
      end
  
      def move_position(offset_x, offset_y)
        bash = ''
        if (offset_y > 0) 
          bash << "\e[#{offset_y}B"
        else 
          bash << "\e[#{offset_y.abs}A"
        end
        if (offset_x > 0) 
          bash << "\e[#{offset_x}C"
        else
          bash << "\e[#{offset_x.abs}D"
        end
        bash
      end
  
      def write_to_position (x, y, text, font = Font.new)
        bash = ''
        bash << save_position()
        bash << move_position(x, y)
        bash << write(text, font)
        bash << restore_position()
        bash
      end
  
      def write (text, font = Font.new) 
        font.to_bash + text + Font::RESET
      end
  
      def write_ln (text, font = @@default_font) 
        print font.to_bash + text << "\n" << Font::RESET
      end
  
      def erase_to_end_line
        "\e[K"
      end
  
      def clear 
        set_position(0, 0) + "\e[2J"
      end
    end
  end
end