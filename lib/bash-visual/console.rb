module Bash_Visual
  class Console
    include Painter

    @@mutex = Mutex.new

    OUTPUT_STRING = 0
    OUTPUT_WITHOUT_BLOCK = 1
    OUTPUT_WITH_BLOCK = 2
    attr_reader :current_x, :current_y, :font;

    # @param [Bash_Visual::Font] font
    # @param [Object] way_output
    # @param [Bash_Visual::Builder] builder
    def initialize (font = Font.new, way_output = OUTPUT_WITHOUT_BLOCK, builder = Builder.new)
      @current_x = 0
      @current_y = 0
      @font = font
      @way_output = way_output
      @builder = builder
    end

    def position= coord
      @current_x , @current_y = *coord
      print @builder.set_position(@current_x, @current_y)
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

    def write_ln (text = '', font = @font)
      print @builder.write_ln(text, font)
    end

    def erase_to_end_line
      print @builder.erase_to_end_line
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

    def lines
      `tput lines`
    end

    def cols
      `tput cols`
    end

    private
    def print string

      return string if OUTPUT_STRING == @way_output

      if OUTPUT_WITH_BLOCK == @way_output
        @@mutex.synchronize {super}
      else
        super
      end
    end

  end
end