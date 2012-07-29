module Bash_Visual
  class Scroll

    include FixedObject

    FORWARD  = 1
    BACKWARD = -1

    BEGINNING = false
    ENDING    = true

    attr_reader :console


    # @param [Hash] options
    #
    # options = {
    #   position: [x, y],
    #   size: [width, height],
    #   font: Font.new (:bold)
    #   start: Scroll::ENDING,
    #   adapt_size_message: true,
    #   prefix: -> { '>' }
    #   separator: '-'
    # }
    #
    #
    def initialize(options)

      unless  options[:position] && options[:size]
        raise "Minimum needs: :size and :position"
      end

      @width, @height = options[:size]
      @x, @y          = options[:position]
      @prefix         = options[:prefix]
      @adapt          = options[:adapt].nil? ? true : options[:adapt]
      @separator      = options[:separator]

      @max_message_block_size   = options[:max_message_block_size]
      @fixed_message_block_size = options[:fixed_message_block_size]

      @start = options[:start] ? ENDING : BEGINNING
      @font  = options[:font] ? options[:font] : Font.new

      @stack     = []
      @stateless = false

      @console = Console.new @font, Console::OUTPUT_STRING
      @mutex   = Mutex.new

    end

    def scroll(positions = 1, direction = @direction * positions)

    end

    # @param [String] message
    # @param [Bash_Visual::Font] font
    def add(message, font = @font)

      unless font.background
        font = Font.new font.types, font.foreground, @font.background
      end

      @stack << {message: prefix() + message.to_s, font: font}

      clear
      redraw

      nil
    end


    # @param [Proc] prefix
    def prefix= (prefix)
      @prefix = prefix
    end

    def prefix
      return @prefix[].to_s if (defined? @prefix.call)
      ''
    end

    class << self
      def form_block(text, size, fixate = false)
        width, height = size
        result        = []

        height.times do |i|
          line = text[i * width, width]

          unless line
            break unless fixate
            result.fill(' ' * width, i, height - i)
            break
          end

          result << line.ljust(width)
        end

        result
      end
    end

    private

    def redraw
      avail_area = [@width, @height]
      @stack.reverse.each do |item|

        message    = item[:message]
        font       = item[:font]
        avail_area = print_message(message, font, avail_area)

        return nil if avail_area[0] <= 0 or avail_area[1] <= 0
      end
    end

    # @param [Integer] x
    # @param [Integer] y
    # @param [Array] message
    # @param [Bash_Visual::Font] font
    def write(x, y, message, font)
      string = ''
      message.each_with_index { |text, i|
        string << @console.write_to_position(x, y + i, text, font)
      }

      @mutex.synchronize {
        print string
      }
    end

    private

    # Clear scroll's area
    def clear(font = @font)
      print @console.draw_filled_rectangle([@x, @y], [@width, @height], font.background)
    end
  end
end