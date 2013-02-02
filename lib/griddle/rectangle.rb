module Griddle
  class Rectangle
    # attr_accessor :top, :left, :width, :height
    
    def initialize(top, left, width, height)
      @top = top
      @left = left
      @width = width
      @height = height
    end
    
    def read(csv, &block)
      
    end
  end
end