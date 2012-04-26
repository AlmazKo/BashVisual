$:.unshift(File.dirname(__FILE__))

require 'console'

class Scroll
  
  FORWARD  = 1
  BACKWARD = -1
  
  BEGINNING = false
  ENDING    = true
  
  attr_accessor :console 
  
  def initialize(options)

    @x, @y = options[:coordinates]
    @x = @x.to_i
    @y = @y.to_i

    raise ':window_size isn\'t array' unless options[:window_size].instance_of? Array
    raise 'size :window_size must be great than 1' if options[:window_size].size < 2
      
    @area_width, @area_height = options[:window_size]
    @area_width = @area_width.to_i
    @area_height = @area_height.to_i

    @message_block_size = options[:message_block_size] ? options[:message_block_size].to_i : 1
    @message_block_size = 1 if @message_block_size < 1
   
    @prefix = options[:prefix] ? options[:prefix] : nil
    
    @adapt_size_message = options[:adapt_size_message] ? options[:adapt_size_message] : false
    
    @is_wrap = true
    @start = options[:start] ? ENDING : BEGINNING
    @separator = options[:separator] ? options[:separator] : false
    @font = options[:font] ? options[:font] : nil

    @stack = []
    @console = Console.new @font,Console::OUTPUT_STRING
    @mutex = Mutex.new
  end
  
  def scroll(positions = 1, direction = @direction * positions)

  end
  
  def add (message, font = @font)
    
    if @stack.size.zero? 
      print @console.draw_rectangle(@x + 1, @y + 1, @area_width, @area_height, font)
    end
    
    @stack << {
      message: prefix() << message.to_s,
         font: font
    }

    redraw()
    #@stack.slice!(-index, index)
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

  def redraw
    avail_area = [@area_width, @area_height]
    @stack.reverse.each do |item|
      
      message = item[:message].dup.lines.to_a
      font = item[:font]
      unless font.background
        font = Font.new font.font, font.foreground, @font.background
      end

      avail_area = print_message(message, font, avail_area)
      # выходим если закончилось место в области
      return nil if avail_area[0] <= 0 or avail_area[1] <= 0
    end
  end
  
  # сделать переносы в массиве строк
  def rows_wrap! arr, max_len
    max_used_len = 1
    arr.each_with_index do |row, i| 
      len = row.size
      max_used_len = len if len > max_used_len
      next if len <= max_len
      tail = row.slice!(max_len,  len-max_len)
      arr.insert(i+1, tail)
    end
    max_used_len
  end
  
  def write (x, y, message, font)


    string = ''
    message.each_with_index { |text, i|   
     string << @console.write_to_position(x, y + i, text, font)
    }
      
    @mutex.synchronize {
      print string
    }
  end
end
