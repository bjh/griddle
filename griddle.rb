require_relative 'lib/data_store.rb'

data_store = DataStore.new('data/po.csv')

puts "Vendor"
puts data_store.cut(11, 1, 1, 5)
puts
puts "Ship To"
shipto = data_store.find("SHIP TO")
puts data_store.cut(shipto.row+1, shipto.col, 1, 5)

