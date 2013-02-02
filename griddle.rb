require_relative 'lib/griddle/data_store.rb'

iron = Griddle::DataStore.new('po.csv')

# puts "Vendor"
# puts iron.section(10, 0, 1, 5)
# puts
# puts "Ship To"
# output = iron.section(10, 3, 1, 5) do |what|
#   [what[0].to_s.slice(1, what[0].size-2)]
# end
# puts output
# puts

items = iron.section(20, 0, 7, 2) do |row|
  puts row.join "|"
end