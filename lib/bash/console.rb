$:.unshift(File.dirname(__FILE__))
require 'font'
require 'builder'

class Console
  @@mutex = Mutex.new
  
  OUTPUT_STRING = 0
  OUTPUT_WITHOUT_BLOCK = 1
  OUPUT_WITH_BLOCK = 2
  # see: http://en.wikipedia.org/wiki/Box-drawing_characters
  BORDER_UTF         = ["\u250C","\u2500","\u2510",
                        "\u2502",         "\u2502",
                        "\u2514","\u2500","\u2518"]
                    
  BORDER_UTF_ROUND   = ["\u256D","\u2500","\u256E",
                        "\u2502",         "\u2502",
                        "\u2570","\u2500","\u256F"]

  BORDER_UTF_DOUBLE  = ["\u2554","\u2550","\u2557",
                        "\u2551",         "\u2551",
                        "\u255A","\u2550","\u255D"]

  attr_reader :current_x, :current_y, :font; 
  
  def initialize (font = Font.new, way_outnput = OUTPUT_WITHOUT_BLOCK, builder = Builder.new)
    @current_x = 0
    @current_y = 0
    @font = font
    @way_output = way_outnput
    @builder = builder
  end
  
  def position= (x, y)
    @current_x , @current_y = x, y
    print @builder.set_position(x, y)
  end
  
  def move_position(offset_x, offset_y)
    @current_x += offset_x
    @current_y += offset_y
    print @builder.move_position(offset_x, offset_y)
  end
  
  # Записать что-то в определенной позиции, а потом вернуться на текущую
  # Если необходимо сохранить позицию после записи - используйте связку 
  # move_position/position= и write
  def write_to_position (x, y, text, font = @font)
    print @builder.write_to_position(x, y, text, font)
  end
  
  def write (text, font = @font) 
    print @builder.write(text, font) 
  end

  def write_ln (text, font = @font) 
    print @builder.write_ln(text, font) 
  end

  def erase_to_end_line
    print @builder.erase_to_end_line
  end
  
  def draw_rectangle(x, y, width, height, font = nil)
    bash = ''
    bash << @builder.save_position()
    bash << @builder.set_position(x,y)
    height.times do
      bash << @builder.write(' ' * width, font)
      bash << @builder.move_position(-width, 1)
    end
    bash << @builder.restore_position()
    print @builder.write(bash, font)
  end
  
  def draw_border(x, y, width, height, font = nil, border = BORDER_UTF)
    raise 'width,height must be grait than 1' if (width < 2 or height < 2)
    
    bash = ''
    bash << @builder.save_position()
    bash << @builder.set_position(x,y)
    
    bash << border[0] << border[1] * (width - 2) <<  border[2] << "\n"
    (height - 2).times do
      bash << border[3] << ' ' * (width - 2) << border[4]<< "\n"
    end
    bash << border[5] << border[6] * (width - 2) << border[7]
    
    bash << @builder.restore_position()
    print @builder.write(bash, font)
  end
  
  def draw_window(x, y, width, height, text = '', font = nil, border = BORDER_UTF_DOUBLE, text_wrap = ["\u2561","\u255E"])
    raise 'width,height must be grait than 2' if (width < 3 or height < 3)
    
    text = text.slice(0, width - 2)
    if text.size < (width - 3) && (text_wrap.instance_of? Array)
      text = text_wrap[0] + text + text_wrap[1]
    end
    text = text.center(width - 2, border[1])
    bash = ''
    bash << @builder.save_position()
    bash << @builder.set_position(x,y)
    
    bash << border[0] << text <<  border[2] << "\n"
    (height - 2).times do
      bash << border[3] << ' ' * (width - 2) << border[4]<< "\n"
    end
    bash << border[5] << border[6] * (width - 2) << border[7]
    
    bash << @builder.restore_position()
    print @builder.write(bash, font)
  end
  
  # Clear the screen and move to (0,0)
  def clear
    @current_x = 0
    @current_y = 0
    print @builder.clear
  end

  def font= font
    @font = font
  end
  
  private
  def print string

    return string if OUTPUT_STRING == @way_output
   
    if OUPUT_WITH_BLOCK == @way_output
      @@mutex.synchronize {super}
    else
      super
    end
  end
  
end