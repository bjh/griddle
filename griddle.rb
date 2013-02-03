require_relative 'lib/data_store.rb'

iron = DataStore.new('po.csv')

puts "Vendor"
puts iron.cut(11, 1, 1, 5)
puts
puts "Ship To"
shipto = iron.scan("SHIP TO")
puts iron.cut(shipto.row+1, shipto.col, 1, 5)

