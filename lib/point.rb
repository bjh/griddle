require_relative 'rectangle.rb'

module Griddle
  class DataPoint < Struct.new(:row, :col)
    def to_s
      "[#{row}, #{col}]"
    end

    def nil?
      row.nil? && col.nil?
    end

    def delta(data_point)
      DataPoint.new(
        (self.row - data_point.row).abs,
        (self.col - data_point.col).abs
      )
    end

    def to_rectangle(data_point)
      d = delta(data_point)

      DataRectangle.new(
        row,
        col,
        d.col + 1,
        d.row + 1
      )
    end
  end

  # NOTE: possibe overkill - I have been reading POODIR [yes that sounds like another name for lady parts]
  NullDataPoint = DataPoint.new(nil, nil)
end
