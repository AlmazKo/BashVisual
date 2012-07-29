module Bash_Visual
  class VerticalScroll < Scroll

    def get_y_position available_area_height, message_size = 0
      if (@start == BEGINNING)
        @y + (@height - available_area_height)
      else
        @y + available_area_height - message_size
      end
    end

    def print_message message, font, available_area

      available_area_width, available_area_height = available_area

      msg_block_height =
          case
            when !@adapt
              1
            when @fixed_message_block_size
              @fixed_message_block_size
            when @max_message_block_size
              @max_message_block_size
            else
              available_area_height
          end

      msg_block_height -= 1 if @separator
      msg_block_height = available_area_height if msg_block_height > available_area_height

      message = Scroll.form_block message, [available_area_width, msg_block_height]
      if @separator
        message << @separator * available_area_width
      end

      write(@x, get_y_position(available_area_height, message.size), message, font)

      [available_area_width, available_area_height - message.size]
    end

  end
end
