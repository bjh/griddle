require 'csv'
require_relative 'point'

module Griddle
  class DataGrid
    def initialize(file, start_counting_at_zero=false)
      @offset = start_counting_at_zero ? 0 : 1
      @grid = []

      CSV.foreach(file) do |row|
        @grid << row
      end
    end

    def find(what)
      matches = []

      @grid.each_with_index do |row, index|
        matches << Point.new(*offset_up(index, row.index(what))) if !row.index(what).nil?
      end

      # only returning the last match for now until a better way to handle
      #   multiple results pops into my head
      if matches.size > 0
        matches.last
      else
        NullPoint
      end
    end

    def cut(top, left, width, height)
      top, left = offset_down(top, left)
      selection = []

      for row in top...(top+height)
        row_data = []

        for col in left...(left+width)
          row_data << @grid[row][col]
        end

        selection << row_data
      end

      selection
    end

    def cut_rectangle(rectangle)
      cut(rectangle.top, rectangle.left, rectangle.width, rectangle.height)
    end

    private

    def offset_down(*args)
      args.collect {|n| n - @offset}
    end

    def offset_up(*args)
      args.collect {|n| n + @offset}
    end
  end
end