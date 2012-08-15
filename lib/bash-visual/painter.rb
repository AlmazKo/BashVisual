# coding: utf-8

module Bash_Visual
  module Painter

    @@default_window_wrap = ["\u257C ", " \u257E"]
    #@@default_window_wrap = ["", ""]

    # see: http://en.wikipedia.org/wiki/Box-drawing_characters
    BORDER_UTF            = ["\u250C", "\u2500", "\u2510",
        "\u2502", "\u2502",
        "\u2514", "\u2500", "\u2518"]

    BORDER_UTF_ROUND = ["\u256D", "\u2500", "\u256E",
        "\u2502", "\u2502",
        "\u2570", "\u2500", "\u256F"]

    BORDER_UTF_DOUBLE = ["\u2554", "\u2550", "\u2557",
        "\u2551", "\u2551",
        "\u255A", "\u2550", "\u255D"]



    # @param [Array] positioning
    # @param [Integer] color
    def draw_filled_rectangle(*positioning, color)
      x, y, width, height = prepare_positioning positioning
      raise 'width,height must be great than 1' if (width < 1 or height < 1)

      color = color.background if color.is_a? Font
      font = Font.new :std, :white, color

      bash = @builder.save_position
      bash << @builder.set_position(x+1, y+1)

      row = @builder.write(' ' * width)
      row << @builder.move_position(-width, 1)
      bash << row*height

      bash << @builder.restore_position
      print @builder.write(bash, font)
    end

    # @param [Array] positioning
    def draw_border(*positioning, &extra)
      x, y, width, height = prepare_positioning positioning do |x2, y2, width2, height2|
        next x2, y2, width2 + 2, height2 + 2
      end

      raise 'width,height must be great than 2' if (width < 2 or height < 2)

      params = block_given? ? yield : {}
      border = params[:border] ? params[:border] : BORDER_UTF
      font   = params[:font] ? params[:font] : @font

      bash = @builder.save_position
      bash << @builder.set_position(x, y)
      body_width = width - 2

      bash << @builder.write(border[0] + border[1] * body_width + border[2])

      row = @builder.move_position(-width, 1)
      row << @builder.write(border[3] + ' ' * body_width + border[4])
      bash << row*(height - 2)

      bash << @builder.move_position(-width, 1)
      bash << @builder.write(border[5] + border[6] * body_width + border[7])

      bash << @builder.restore_position
      print @builder.write(bash, font)
    end


    # @param [Array] positioning
    # @param [String] text
    def draw_window(*positioning, text, &params)

      x, y, width, height = prepare_positioning positioning do |x2, y2, width2, height2|
        next x2, y2, width2 + 2, height2 + 2
      end

      raise 'width,height must be great than 2' if (width < 3 or height < 3)

      params = block_given? ? yield : {}


      wrap   = params[:wrap].nil? ? @@default_window_wrap : params[:wrap]
      border = params[:border] ? params[:border] : BORDER_UTF
      font   = params[:font] ? params[:font] : @font

      body_width = width - 2
      text = if wrap
               wrap_size  = wrap[0].size + wrap[1].size
               text_width = body_width - wrap_size
               if text_width < 0
                 text.to_s.slice(0, body_width)
               else
                 wrap[0] + text.to_s[0, text_width] + wrap[1]
               end
             else
               text.to_s.slice(0, body_width)
             end

      text = text.center(body_width, border[1])

      bash = @builder.save_position
      bash << @builder.set_position(x, y)

      bash << @builder.write(border[0] + text + border[2])

      row = @builder.move_position(-width, 1)
      row << @builder.write(border[3] + ' ' * body_width + border[4])
      bash << row*(height - 2)

      bash << @builder.move_position(-width, 1)
      bash << @builder.write(border[5] + border[6] * body_width + border[7])

      bash << @builder.restore_position
      print @builder.write(bash, font)
    end

    private
    # @param [Array] positioning
    def prepare_positioning(positioning, &extra)
      if positioning.size == 2
        x, y          = positioning[0]
        width, height = positioning[1]
      else
        fixed_object = positioning[0]
        raise 'Must be FixedObject' unless fixed_object.kind_of?(FixedObject)

        x, y          = fixed_object.position
        width, height = fixed_object.size

        if block_given?
          x,y,width,height = yield(x, y, width, height)
        end
      end

      return x, y, width, height
    end

  end
end