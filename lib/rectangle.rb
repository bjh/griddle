module Griddle
  class Rectangle < Struct.new(:top, :left, :width, :height)
    def self.create(top_left, bottom_right)
      top_left.to_rectangle(bottom_right)
    end
  end
end
