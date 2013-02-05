require 'csv'

class Point < Struct.new(:row, :col)
  def to_s
    "[#{row}, #{col}]"
  end
  
  def nil?
    row.nil? && col.nil?
  end
end

# NOTE: possibe overkill - I have been reading POODIR [yes that sounds like another name for lady parts]
NullPoint = Point.new(nil, nil)

class DataStore
  def initialize(file, start_counting_at_zero=false)
    @offset = start_counting_at_zero ? 0 : 1
    @grid = []
      
    CSV.foreach(file) do |row|
      @grid << row
    end
  end
    
  def find(what)
    @grid.each_with_index do |row, index|
      return Point.new(*offset_up(index, row.index(what))) if !row.index(what).nil?
    end
    
    NullPoint
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
  
  private 
  
  def offset_down(*args)
    args.collect {|n| n - @offset}
  end
  
  def offset_up(*args)
    args.collect {|n| n + @offset}
  end
end
