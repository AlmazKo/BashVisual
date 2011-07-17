# To change this template, choose Tools | Templates
# and open the template in the editor.

class Console
  attr_reader :current_x, :current_y; 
  
  def initialize (font = '')
    @current_x = 0
    @current_y = 0
    @default_font = font
  end
  
  def set_position (line, col)
    @current_x , @current_y = line, col
    print "\e[#{col.to_i};#{line.to_i}H"
  end
  
  def move_position (x, y)

    @current_x += x
    @current_y += y

    bash_command = ''
    if (y > 0) 
      bash_command << "\e[#{y}B"
    else 
      bash_command << "\e[#{y.abs}A"
    end
    if (x > 0) 
      bash_command << "\e[#{x}C"
    else
      bash_command << "\e[#{x.abs}D"
    end
    
    print bash_command
  end
  
  # Записать что-то в определенной позиции, а потом вернуться на текущую
  # Если необходимо сохранить позицию после записи - используйте связку 
  # move_position/set_position и write
  def write_to_position (x, y, text, font = nil)
    save_position()
    move_position(x, y)

    write(text, font)
    restore_position()
  end
  
  def write (text, font = nil) 
    if (!font)
     font = @default_font
    end
    print font.to_bash + text + Font::RESET
  end
  
  def write_ln (text, font = nil) 
    if (!font)
     font =  @default_font
    end
    print font.to_bash + text << "\n" << Font::RESET
  end
  
  def erase_to_end_line
    print "\e[K"
  end
  
  def draw_rectangle(x, y, width, height, font = nil, border = nil)
    save_position()
    set_position(x,y)
    height.times do
      write(' ' * width, font)
      move_position(-width, 1)
    end
    restore_position()
  end
  
  # Clear the screen and move to (0,0)
  def clear 
    set_position(0, 0)
    print "\e[2J"
  end
    

  def set_default_font (font)
    @default_font = font
  end

    
  private
    def restore_position
      print "\e[u"
    end
    
    def save_position
      print "\e[s"
    end
    

end