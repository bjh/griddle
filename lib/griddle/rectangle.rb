module Griddle
  class Rectangle < Struct.new(:top, :left, :width, :height)
    # include Comparable

    def self.create(top_left, bottom_right)
      top_left.to_rectangle(bottom_right)
    end

    # TODO: what makes a rectangle less than another?
    #  the width, the position, the height? the size?
    # def <=>(rectangle)
    #   [top, left, width, height] <=> [rectangle.top, rectangle.left, rectangle.width, rectangle.height]
    # end
  end
end
