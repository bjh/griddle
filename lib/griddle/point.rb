require_relative 'rectangle'

module Griddle
  class Point < Struct.new(:row, :col)
    include Comparable

    # TODO: not sure this is really necessary,
    #  it seemed like a good idea at the time
    def <=>(point)
      [row, col] <=> [point.row, point.col]
    end

    def to_s
      "[#{row}, #{col}]"
    end

    def nil?
      row.nil? && col.nil?
    end

    def zero?
      row.zero? && col.zero?
    end

    def delta(point)
      Point.new(
        (self.row - point.row).abs,
        (self.col - point.col).abs
      )
    end

    # `point` is used to calculate the width and height
    #    of the new rectangle
    def to_rectangle(point)
      d = delta(point)

      Rectangle.new(
        row,
        col,
        d.col + 1,
        d.row + 1
      )
    end

    def move(directions)
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

    # some sugar
    [:up, :down, :left, :right].each do |direction|
      define_method direction do |amount|
        move(direction => amount)
      end
    end
  end

  # # return NullPoint instead of nil
  # NullPoint = Point.new(nil, nil)
  # # for no apparent reason
  # ZeroPoint = Point.new(0, 0)
end
