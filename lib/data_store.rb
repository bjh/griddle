require 'csv'

class Point < Struct.new(:row, :col)
  def to_s
    "[#{row}, #{col}]"
  end
  
  def nil?
    row.nil? && col.nil?
  end
end

NullPoint = Point.new(nil, nil)

class DataStore
  def initialize(file, start_counting_at_zero=false)
    @offset = start_counting_at_zero ? 0 : 1
    @grid = []
      
    CSV.foreach(file) do |row|
      @grid << row
    end
  end
    
  def scan(what)
    @grid.each_with_index do |row, index|
      return Point.new(*offset_up(index, row.index(what))) if !row.index(what).nil?
    end
    
    NullPoint
  end
    
  def cut(top, left, width, height)
    # puts "cut(#{top}, #{left}, #{width}, #{height})"
    top, left = offset(top, left)
    # puts "cutting at: #{top}, #{left}"
    selection = []
      
    for row in top...(top+height)
      rdata = []
        
      for col in left...(left+width)
        rdata << @grid[row][col]
      end
      # puts "rdata: #{rdata}"
      selection << rdata      
    end
      
    selection
  end
  
  private 
  
  def offset(*args)
    args.collect {|n| n - @offset}
  end
  
  def offset_up(*args)
    args.collect {|n| n + @offset}
  end
end
