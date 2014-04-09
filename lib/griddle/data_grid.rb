require 'csv'
require 'terminal-table'
require_relative 'point'

module Griddle
  class DataGrid
    include Enumerable
    attr_accessor :case_sensitive, :offset, :grid

    def self.from_csv(csv)
      DataGrid.new.populate_from_csv(csv)
    end

    def initialize(start_counting_at_zero=false)
      @offset = start_counting_at_zero ? 0 : 1
      @grid = []
      @case_sensitive = false
    end

    def to_rectangle
      Rectangle.new(0, 0, width, height)
    end

    def width
      grid[0].size
    end

    def height
      grid.size
    end

    # make Enumerable
    def each(&block)
      grid.each do |row|
        block.call(row)
      end
    end

    def to_s
      Terminal::Table.new(rows: grid)
    end

    def populate_from_csv(csv_file_path)
      CSV.foreach(csv_file_path) {|row| self.grid << row}
      self
    end

    def populate_from_data(data)
      self.grid = data
      self
    end

    def finder(row, index, what)
      return false if row[index].nil?

      if case_sensitive
        row[index] == what
      else
        row[index].downcase == what.downcase
      end
    end

    def find(what)
      matches = []

      grid.each_with_index do |row, row_index|
        row.each_index.select {|n| finder(row, n, what)}.each do |column|
          matches << Point.new(*offset_up(row_index, column))
        end
      end

      matches
    end

    def cut(top, left, width, height)
      top, left = offset_down(top, left)
      selection = []

      for row in top...(top+height)
        row_data = []

        for col in left...(left+width)
          row_data << grid[row][col]
        end

        selection << row_data
      end

      DataGrid.new.populate_from_data(selection)
    end

    def cut_rectangle(rectangle)
      cut(rectangle.top, rectangle.left, rectangle.width, rectangle.height)
    end

    def offset_down(*args)
      args.collect {|n| n - offset}
    end

    def offset_up(*args)
      args.collect {|n| n + offset}
    end
  end
end
