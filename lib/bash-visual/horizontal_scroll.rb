module Bash_Visual
  class HorizontalScroll < Scroll

    DEFAULT_SEPARATOR = "\u2502"

    def initialize options
      super

      @separator =
        if @separator == true;                  DEFAULT_SEPARATOR
        elsif @s.instance_of? String;   @separator[0]
        else                                    nil
      end
    end

    def get_x_position available_area_width, message_width = 0
      if (@start == BEGINNING)
        @x + (@width - available_area_width)
      else
        @x + available_area_width - message_width
      end
    end

    def print_message message, font, available_area

      available_area_width, available_area_height = available_area

      msg_block_width =
          case
            when @fixed_message_block_size
              @fixed_message_block_size
            when @max_message_block_size
              @max_message_block_size
            else
              available_area_width
          end

      msg_block_width -= 1 if @separator
      msg_block_width = available_area_width if msg_block_width > available_area_width

      #msg_block_height = @adapt ? available_area_height : 1

      message = Scroll.form_block message, [msg_block_width, available_area_height], @fixed_message_block_size
      if @separator
        message.map! do |row|
          row = row + DEFAULT_SEPARATOR
        end
      end

      msg_block_width += 1
      write(get_x_position(available_area_width, msg_block_width), @y, message, font)

      [available_area_width - msg_block_width, available_area_height]
    end
  end
end