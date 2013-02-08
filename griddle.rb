require_relative 'lib/data_store.rb'

data_store = DataStore.new('data/po.csv')

puts "Vendor"
candy = data_store.cut(11, 1, 1, 5)
puts candy
puts
puts "Ship To"
shipto = data_store.find("SHIP TO")
puts shipto
puts data_store.cut(shipto.row+1, shipto.col, 1, 5)

data_store.cut(21, 1, 7, 2).each do |row|
  puts row.join(":")
end