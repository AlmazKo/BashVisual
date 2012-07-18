# coding: utf-8

module Bash_Visual
  class Builder

    def initialize (font = Font.new)
      @default_font = font
    end

    def clear
      set_position(0, 0) + "\e[2J"
    end

    def erase_to_end_line
      "\e[K"
    end

    def restore_position
      "\e[u"
    end

    def save_position
      "\e[s"
    end

    def set_position(x, y)
      "\e[#{y.to_i};#{x.to_i}H"
    end

    def move_position(offset_x, offset_y)
      bash = ''
      if (offset_y > 0)
        bash << "\e[#{offset_y}B"
      else
        bash << "\e[#{offset_y.abs}A"
      end
      if (offset_x > 0)
        bash << "\e[#{offset_x}C"
      else
        bash << "\e[#{offset_x.abs}D"
      end
      bash
    end

    def write_to_position(x, y, text, font = @default_font)
      bash = ''
      bash << save_position()
      bash << move_position(x, y)
      bash << write(text, font)
      bash << restore_position()
      bash
    end

    def write(text, font = @default_font)
      font.to_bash + text + Font::RESET
    end

    def write_ln(text, font = @default_font)
      font.to_bash + text.to_s + $/ + Font::RESET
    end
  end
end