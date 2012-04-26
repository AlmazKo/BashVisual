require 'scroll'

class HorizontalScroll < Scroll
  
  DEFAULT_SEPARATOR = "\u2502"
  
  def initialize options
    super
    @message_block_width = @message_block_size

    @separator = 
      if @separator == true;                  DEFAULT_SEPARATOR
      elsif @separator.instance_of? String;   @separator[0]
      else                                    nil
    end
  end
  
  def get_x_position available_area_width, message_width = 0
    if (@start == BEGINNING)
      @x + (@area_width - available_area_width)
    else
      @x + available_area_width - message_width
    end
  end
  
  def print_message message, font, available_area
    
    available_area_width, available_area_height = available_area
    avail_width = @message_block_width > available_area_width ? available_area_width : @message_block_width
    
    
    (available_area_height - message.size).times {
      message << ''
    }
    
    if @adapt_size_message
      message_width = rows_wrap! message, available_area_width
    else
      rows_wrap! message, avail_width
      message_width = avail_width
    end
    
    message = message.slice(0, available_area_height) if message.size > available_area_height
    
    message.map! do |row|
        row.strip.ljust(message_width)
    end
    
    if @separator and @separator.size.nonzero?
      if @adapt_size_message
        if message_width < available_area_width
          message.map! do |row|
              row << @separator
          end
          message_width += 1
        end
      else
        message.each do |row|
            row[message_width-1] = @separator
        end
      end
    end

    write(get_x_position(available_area_width, message_width), @y, message, font)

    [available_area_width - message_width, available_area_height]
  end
  
end
