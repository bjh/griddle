require_relative 'rectangle.rb'

module Griddle
  class Point < Struct.new(:row, :col)
    def to_s
      "[#{row}, #{col}]"
    end

    def nil?
      row.nil? && col.nil?
    end

    def delta(data_point)
      Point.new(
        (self.row - data_point.row).abs,
        (self.col - data_point.col).abs
      )
    end

    def to_rectangle(data_point)
      d = delta(data_point)

      Rectangle.new(
        row,
        col,
        d.col + 1,
        d.row + 1
      )
    end

    def move(directions={})
      directions.each_pair do |direction, amount|
        amount = amount.to_i

        case direction.to_sym
        when :up
          self.row -= amount
        when :down
          self.row += amount
        when :left
         self.col -= amount
        when :right
         self.col += amount
        end
      end
    end
  end

  # NOTE: possibe overkill - I have been reading POODIR [yes that sounds like another name for lady parts]
  NullPoint = Point.new(nil, nil)
end
