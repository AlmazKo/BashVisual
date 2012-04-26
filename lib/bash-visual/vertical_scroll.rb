module Bash_Visual
  class VerticalScroll < Scroll

    def initialize options
      super
      @message_block_height = @message_block_size
    end

    def get_y_position available_area_height, message_size = 0
      if (@start == BEGINNING)
        @y + (@area_height - available_area_height)
      else
        @y + available_area_height - message_size
      end
    end

    def print_message message, font, available_area

      available_area_width, available_area_height = available_area
      avail_height = @message_block_height > available_area_height ? available_area_height : @message_block_height

      rows_wrap!(message, available_area_width) if @is_wrap

      if @adapt_size_message
        message = message.slice(0, available_area_height) if message.size > available_area_height
      else
        message = message.slice(0, avail_height) if message.size > avail_height
      end

      message.map! do |row|
          row.strip.ljust(available_area_width)
      end

      if @separator == true
        message[message.size-1] = Font.new(Font::UNDERLINE, font.foreground, font.background).to_bash +
          message.last.ljust(available_area_width, ' ')
      end

      if (@separator.instance_of? String)
        if (message.size > available_area_height)
          message[message.size-1] = @separator[0] * available_area_width
        else
          message << @separator[0] * available_area_width
        end
      end

      write(@x, get_y_position(available_area_height, message.size), message, font)


      [available_area_width, available_area_height - message.size]
    end

  end
end
