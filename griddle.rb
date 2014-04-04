$: << File.expand_path(File.dirname(__FILE__) + '/lib')
require 'griddle.rb'

data_store = Griddle::DataGrid.new('data/po.csv')

# I know where the Vendor data is from looking at the Purchase Order
puts "<Vendor>"
candy = data_store.cut(11, 1, 1, 5)
puts candy
puts

# the Ship To data might move down a line or two
# so search for it's location based off of it's column header
puts "<Ship To>"
shipto = data_store.find("SHIP TO")
puts "ship to header location: #{shipto}"
puts data_store.cut(shipto.row+1, shipto.col, 1, 5)
puts

# iterate over the line item rows returned in a Rectangle
puts "<line items>"
data_store.cut(21, 1, 7, 2).each do |row|
  puts row.join(":")
end
puts

# search for two different points and use them to make a Rectangle
puts "<rectangle from points>"
tl = data_store.find("TAX RATE")
br = data_store.find("TOTAL")
puts data_store.cut_rectangle(Griddle::Rectangle.create(tl, br))


# try out the Point.move functionality
# use the previous Ship To example
puts
puts "<Ship To with move>"
shipto = data_store.find("SHIP TO")
shipto.move(down:1)
puts data_store.cut(shipto.row, shipto.col, 1, 5)
