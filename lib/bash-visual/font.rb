module Bash_Visual
  class Font

    COLORS = [:black, :dark_red, :dark_green, :dark_yellow, :dark_blue, :dark_magenta, :dark_cyan, :grey,
              :dark_grey, :red, :green, :yellow, :blue, :magenta, :cyan, :white]

    TYPES = [:std, :bold, :underline, :blink]

    @@colors_map = {
        black:        0,
        dark_red:     1,
        dark_green:   2,
        dark_yellow:  3,
        dark_blue:    4,
        dark_magenta: 5,
        dark_cyan:    6,
        grey:         7,
        dark_grey:    10,
        red:          11,
        green:        12,
        yellow:       13,
        blue:         14,
        magenta:      15,
        cyan:         16,
        white:        17
    }

    @@types_map = {
        std:       0,
        bold:      1,
        underline: 4,
        blink:     5
    }

    RESET     = "\e[0m"

    attr_reader :types, :foreground, :background

    def initialize(types = :std, foreground = :white, background = nil)

      unless COLORS.include?(foreground)
        raise "not found color #{foreground}"
      end

      @foreground, @background = foreground, background

      @types = prepare_types types

      sequence = []
      @types.each do |type|
        sequence << @@types_map[type]
      end

      color_index = @@colors_map[@foreground]

      sequence << if color_index < 10
                    "3#{color_index}"
                  else
                    "9#{color_index - 10}"
                  end

      if @background
        color_index = @@colors_map[@background]
        sequence << if color_index < 10
                      "4#{color_index}"
                    else
                      "10#{color_index - 10}"
                    end
      end

      @bash_command = "\e[#{sequence.join(';')}m"
    end


    # @return [Array]
    def prepare_types(types)
      case types
        when Symbol then
          [types]
        when Array then
          if types.size > 2
            types.delete_if { |type| type == :std }
          else
            types
          end
        else
          raise "types must be Array or Symbol"
      end
    end

    def inspect
      "<Font types=%s, foreground=%s, background=%s>" %
          [@types, @foreground, (@background ? @background : 'nil')]
    end

    def to_s
      @bash_command
    end

    alias to_bash to_s

    class << self

      # @param [Symbol] exclude_color
      def rand_color (exclude_color = nil)
        color = rand(16)
        color += 2 if color > 7

        if color == @@colors_map[exclude_color]
          color += 1
          color = 0 if color > 17
        end

        @@colors_map.each do |name, code|
          return name if code == color
        end

      end
    end

  end
end