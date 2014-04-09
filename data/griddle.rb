$: << File.expand_path(File.dirname(__FILE__) + './lib')
require 'griddle.rb'

grid = Griddle::DataGrid.new.populate_from_csv('po.csv')

# I know where the Vendor data is from looking at the Purchase Order
#   so I cut a rectangle that contains that data
puts "<Vendor>"
candy = grid.cut(11, 1, 1, 5)
puts candy.to_s
puts

# the Ship To data might move down a line or two
# so search for it's location based off of it's column header
puts "<Ship To>"
shipto = grid.find("SHIP TO").last
puts "ship to header location: #{shipto}"
puts grid.cut(shipto.row+1, shipto.col, 1, 5).to_s
puts

# iterate over the line item rows returned in a Rectangle
puts "<line items>"
grid.cut(21, 1, 7, 2).each do |row|
  puts row.join(":")
end
puts

# search for two different points and use them to make a Rectangle
puts "<rectangle from points>"
tl = grid.find("TAX RATE").last
br = grid.find("TOTAL").last
puts grid.cut_rectangle(Griddle::Rectangle.create(tl, br)).to_s


# try out the Point.move functionality
# use the previous Ship To example
puts
puts "<Ship To with move>"
shipto = grid.find("SHIP TO").last
shipto.move(down:1)
puts grid.cut(shipto.row, shipto.col, 1, 5).to_s


# show cash money info
puts
puts "<want mo money!>"
puts grid.cut(38, 6, 2, 4).to_s
