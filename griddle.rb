$: << File.expand_path(File.dirname(__FILE__) + '/lib')
require 'data_store.rb'

data_store = Griddle::DataStore.new('data/po.csv')

puts "<Vendor>"
candy = data_store.cut(11, 1, 1, 5)
puts candy
puts
puts "<Ship To>"
shipto = data_store.find("SHIP TO")
puts "ship to: #{shipto}"
puts data_store.cut(shipto.row+1, shipto.col, 1, 5)
puts
puts "<line items>"
data_store.cut(21, 1, 7, 2).each do |row|
  puts row.join(":")
end
puts
puts "<rectangle from points>"
tl = data_store.find("TAX RATE")
br = data_store.find("TOTAL")
puts data_store.cut_rectangle(Griddle::DataRectangle.create(tl, br))
