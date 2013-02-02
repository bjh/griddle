require 'csv'


module Griddle
  class DataStore
    def initialize(file)
      @grid = []
      
      CSV.foreach(file) do |row|
        @grid << row
      end
    end
        
    def section(t, l, w, h, &block)
      selection = []
      
      # @grid[t][l]
      for row in t...(t+h)
        rdata = []
        
        for col in l...(l+w)
          rdata << @grid[row][col]
        end
        
        # puts "rdata: #{rdata}"
        if block_given?
          selection << yield(rdata)
        else
          selection << rdata
        end
      end
      
      selection
    end
  end
end