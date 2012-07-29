# @author 
module Bash_Visual
  module FixedObject

    attr_accessor :width, :height, :x, :y;

    def position
      [@x, @y]
    end

    def size
      [@width, @height]
    end

  end
end