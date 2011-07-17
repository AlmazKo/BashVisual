$:.unshift(File.dirname(__FILE__))

require 'console'

class Scroll
  
  FORWARD  = 1
  BACKWARD = -1
  
  BEGINNING = 1
  ENDING    = 2
  
  VERTICAL   = 1
  HORIZONTAL = 2
  
  attr_accessor :console 
  def initialize(options)

    if (options[:coordinates])
      @x = options[:coordinates].size > 0 ? options[:coordinates].shift : 1
      @y = options[:coordinates].size > 0 ? options[:coordinates].shift : 1
    end
    
    if (options[:size])
      @area_width  = options[:size].size > 0 ? options[:size].shift : 1
      @area_height = options[:size].size > 0 ? options[:size].shift : 1
    end

    @type = options[:type] ? options[:type] : VERTICAL
    
    if (options[:message_block_size])
      @message_block_width  = options[:message_block_size].size > 0 ? options[:message_block_size].shift : 1
      @message_block_height = options[:message_block_size].size > 0 ? options[:message_block_size].shift : 1

      @message_block_width  = @area_width if @message_block_width > @area_width
      @message_block_height = @area_height if @message_block_height > @area_height
      
      @message_block_width  = 1 if @message_block_width < 1
      @message_block_height = 1 if @message_block_height < 1
    else
      @message_block_width  = @area_width
      @message_block_height = 1
    end
   
    @prefix = options[:prefix] ? options[:prefix] : nil
    
    @adapt_size_message = options[:adapt_size_message] ? options[:adapt_size_message] : false
    
    @start = options[:start] ? options[:start] : BEGINNING
    @start = options[:separator?] ? options[:separator?] : false
    @font = options[:font] ? options[:font] : ''

    @stack = []
    @console = Console.new @font
    @mutex = Mutex.new
  end
  
  def scroll(positions = 1, direction = @direction * positions)

  end
  
  def add (message, font = @font)
    @stack << (prefix() << message.to_s)
    @console.draw_rectangle(@x+1, @y, @area_width-1, @area_height, @font)
    index = write_message(font)
    @stack.slice!(0, index)
  end
  
  def prefix= (prefix)
    @prefix = prefix
  end
  
  def prefix
    if (defined? @prefix.call)
      @prefix[].to_s
    else
      ''
    end
  end

  private
  
  def write_message (font)
    available_area_width = @area_width
    available_area_height = @area_height
    (@stack.size - 1).downto(0) do |i|

      # TODO don't use
      # max_height = @message_block_height > available_area_height ? available_area_height : @message_block_height
      max_available_width = @message_block_width > available_area_width ? available_area_width : @message_block_width
      message = @stack[i].lines.to_a
      message = message.slice(0, @message_block_height) if message.size > @message_block_height
      message.slice!(0, available_area_height + 1) if message.size > available_area_height

      max_used_width = 1
      message.each { |line| 
        line.strip!
        line_size = line.size
        if (line_size > max_used_width)
          max_used_width = line_size
        end
        line.slice!(max_available_width, line.size - max_available_width)
      } 


      message[message.size-1] = Font.new(Font::UNDERLINE, font.foreground, font.background).to_bash + 
        message.last.ljust(max_available_width, ' ')
      write(@x, @y + available_area_height - message.size - 1, message, font)
      if (VERTICAL == @type)
        available_area_width = @area_width
        available_area_height -= message.count
        return i if (available_area_height <= 0) 
      else
        available_area_width -= max_used_width
        available_area_height -= @area_height
        return i if (available_area_width <= 0) 
      end
      
    end
    0
  end
  
  def write (x, y, message, font)
    @mutex.synchronize { 
      message.each_with_index { |text, i|   
        @console.write_to_position(x, y + i, text, font)
      }
    }
  end
end

