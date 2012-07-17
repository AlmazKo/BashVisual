module Bash_Visual
  class Font
    BLACK = 0
    RED = 1
    GREEN = 2
    BROWN = 3
    BLUE = 4
    MAGENTA = 5
    CYAN = 6
    LIGHT_GRAY = 7

    GRAY = 10
    LIGHT_RED = 11
    LIGHT_GREEN = 12
    YELLOW = 13
    LIGHT_BLUE = 14
    LIGHT_MAGENTA = 15
    LIGHT_CYAN = 16
    WHITE = 17

    RESET = "\e[0m"

    #type font
    STD = 0
    BOLD = 1
    UNDERLINE = 2
    BLINK = 4

    attr_reader :type, :foreground, :background

    def parse_types(types)
      base_type = 0
      additional_types = []

      if types.include? BLINK
        base_type = 5

        if types.include? BOLD
          additional_types << 1
        end

        if types.include? UNDERLINE
          additional_types << 4
        end

      else

        if types.include? BOLD
          base_type = 1
        end

        if types.include? UNDERLINE
          if base_type.zero?
            base_type = 4
          else
            additional_types << 4
          end
        end
      end

      return base_type, additional_types
    end


    def initialize(type = STD, foreground = WHITE, background = nil)

      raise "not found color #{foreground}" unless (0..7).cover? foreground or (10..17).cover? foreground

      @type, @foreground, @background = type, foreground, background

      unless @type.is_a? Enumerable
        @type = [@type]
      end

      base_type, additional_types = parse_types @type

      @bash_command = ''

      additional_types.each do |value|
        @bash_command << "\e[#{value}m"
      end

      @bash_command << "\e[#{base_type};"

      if @foreground < 10
        @bash_command << "3#{@foreground}"
      else
        @bash_command << "9#{@foreground - 10}"
      end

      if @background
        if @background < 10
          @bash_command << ";4#{@background}"
        else
          @bash_command << ";10#{@background - 10}"
        end
      end

      @bash_command << 'm'

    end

    def inspect
      "<Font type=%s, foreground=%s, background=%s>" %
          [@type, @foreground, (@background ? @background : 'nil')]
    end

    def to_s
      @bash_command
    end

    alias to_bash to_s

    class << self
      def rand_color (exclude_color = nil)
        color = rand(16)

        if color == exclude_color
          color += 1
          color = 0 if color > 15
        end

        color += 2 if color > 7
        color
      end
    end

  end
end