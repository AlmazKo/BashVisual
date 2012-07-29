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

    # @param [Array] position
    # @param [Array] size
    def draw_filled_rectangle(position, size, color = :white)
      x, y          = *position
      width, height = *size
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

    # @param [Array] position
    # @param [Array] size
    def draw_border(position, size, params = {})
      x, y          = *position
      width, height = *size
      raise 'width,height must be great than 1' if (width < 2 or height < 2)

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

    # @param [Array] position
    # @param [Array] size
    # @param [String] text
    # @param [Hash] params
    def draw_window(position, size, text = '', params = {})
      x, y          = *position
      width, height = *size
      raise 'width,height must be great than 2' if (width < 3 or height < 3)

      wrap   = params[:wrap].nil? ? @@default_window_wrap : params[:wrap]
      border = params[:border] ? params[:border] : BORDER_UTF
      font   = params[:font] ? params[:font] : @font

      body_width = width - 2
      text = if wrap
               wrap_size  = wrap[0].size + wrap[1].size
               text_width = body_width - wrap_size
               wrap[0] + text.to_s[0, text_width] + wrap[1]
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
  end
end