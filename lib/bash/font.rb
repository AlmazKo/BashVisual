
class Font
  BLACK         = 0
  RED           = 1
  GREEN         = 2
  BROWN         = 3
  BLUE          = 4
  MAGENTA       = 5
  CYAN          = 6
  LIGHT_GRAY    = 7

  GRAY          = 10
  LIGHT_RED     = 11
  LIGHT_GREEN   = 12
  YELLOW        = 13
  LIGHT_BLUE    = 14
  LIGHT_MAGENTA = 15
  LIGHT_CYAN    = 16
  WHITE         = 17

  RESET = "\e[0m"
   
  #types font
  STD        = 0
  BOLD       = 1
  UNDERLINE  = 2
  BLINK      = 4
  
  attr_reader :font, :foreground, :background
  
  def initialize (font = STD, foreground = WHITE, background = nil)
    raise "not found color #{foreground}" unless (0..7).cover? foreground or (10..17).cover? foreground
    @font, @foreground, @background = font, foreground, background
    
    @bash_command = ''

    @string = "<type=%s, foreground=%s, background=%s>" % [@font, @foreground, @background]
    if font == STD
      if foreground and foreground < 10
        @bash_command << "\e[3#{foreground}m"
      else
        @bash_command << "\e[9#{foreground-10}m"
      end
    end

    if font & BOLD != 0
      if foreground < 10
        @bash_command << "\e[1;3#{foreground}m"
      else
        @bash_command << "\e[1;9#{foreground-10}m"
      end
    end

    if font & UNDERLINE != 0
      if foreground < 10
        @bash_command << "\e[4;3#{foreground}m"
      else
        @bash_command << "\e[4;9#{foreground-10}m"
      end
    end

    if background.instance_of? Fixnum
      if background < 10
        @bash_command << "\e[4#{background}m"
      else 
        @bash_command << "\e[10#{background-10}m"
      end
    end

  end

  def to_bash
    @bash_command
  end
  
  def to_s
    @string
  end

  class << self
    def rand_color (exclude_color = nil)
      color = rand(14)
      color += 1 if color == exclude_color
      color = 0 if color > 14
      color += 3 if color > 7
      color
    end
  end

 
end