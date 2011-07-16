$:.unshift(File.dirname(__FILE__))

require 'console'

class Scroll
  
  FORWARD  = 1
  BACKWARD = -1
  
  BEGINNING = 1
  ENDING    = 2
  
  VERTICAL   = 1
  HORIZONTAL = 2
  
  def initialize(options)

    @x = options[:x] ? options[:x] : 0
    @y = options[:y] ? options[:y] : 0
    @area_width  = options[:area_width] ? options[:area_width] : 1
    @area_height = options[:area_height] ? options[:area_height] : 1
    
    @type = options[:type] ? options[:type] : VERTICAL
    
    if (!options[:size])
      if (@type == VERTICAL) 
        @size = @area_height
      else
        @size = @area_width
      end
    else
      @size = options[:size]
    end
    
    @adapt_size_message = options[:adapt_size_message] ? options[:adapt_size_message] : false
    
    @start = options[:start] ? options[:start] : BEGINNING
    @font = options[:font] ? options[:font] : ''

    @stack = []
    @console = Console.new @font
    @time_pattern_prefix = options[:time_pattern_prefix] ? options[:time_pattern_prefix] : nil
    @mutex = Mutex.new
  end
  
  def scroll(positions = 1, direction = @direction * positions)

  end
  
  def add (string, font = @font)
    if (@stack.empty?)
      rewrite_all(@font)
    end
    
    if (@stack.size < @size)
      write(@x, @stack.size+@y -1, prefix() << ' ' << string, font)
      @stack << string
    else
      @stack.shift
      @stack << string
      rewrite_all(font)
    end
  end
  
  def time_pattern_prefix= (prefix)
    @time_pattern_prefix = prefix
  end
  
  def prefix
    if (@time_pattern_prefix)
      Time.now.strftime(@time_pattern_prefix)
    else
      ''
    end
  end
  
  
  def rewrite_all (font)
    @console.draw_rectangle(@x, @y, @area_width, @area_height, @font)
    i = -1
    @stack.each { |item| 
      write(@x, @y + i, prefix() << ' ' << item, font)
      i += 1
    }
  end
  
  private
    def write (x, y, text, font)
      @mutex.synchronize { 
        @console.write_to_position(x, y, text, font)
      }
    end
  
end

