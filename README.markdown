Griddle
=======

[![Build Status](https://travis-ci.org/bjh/griddle.svg?branch=master)](https://travis-ci.org/bjh/griddle)
[![Gem Version](https://badge.fury.io/rb/grid-csv.svg)](http://badge.fury.io/rb/grid-csv)
[![Coverage Status](https://coveralls.io/repos/bjh/griddle/badge.png?branch=master)](https://coveralls.io/r/bjh/griddle?branch=master)

**note:** someone has the gem name **griddle** registered already so I am calling the gem **grid-csv**.

This gem was created to help process CSV files that are not really the usual *[row, col]* data.
I have lost many hours of my life in the black hole known as the *coporate intranet*, where windows documents multiply at an obscene rate.
I came up with this idea to help someone handle this particular nastiness.

This is one for my **windows brothers**, of course if it is useful to anyone else I would be delighted.

On To Business
==============

An example of the source material in question would be parsing Excel data that comes from a formatted template. One where the structure is more like a document than a database table.
The template in question may look like this  

![](data/example.png)  

If you exported the Excel data as CSV it may look something like [this](data/po.csv)

Modus Operandi
==============

The main idea to keep in mind is that you are not processing rows and columns of data.
You are cutting out **rectangles** or *grids* of data to process further.

Let's say you have to process a bunch of excel files that captured form data.
The template that was used has a section for the user's contact information.
Instead of ripping through rows and columns you can either:  
- search for a known string and use that as the starting point to cut out a  **rectangle**
- cut out a rectangle from a know location, *i.e.* the contact info starts at row 4, column 3 and is 1 column wide and 4 rows high

The hope is that you can access data in a more intuitive way than just doing a nested for loop and crossing your fingers.

But Why?
=======

Because Microsoft has empowered business people to do **terrible, terrible** things with data.

Small Examples
==============

```ruby
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
```


**NOTE:** This code was originally written to accompany the article [here](http://pregnantfist.tumblr.com/post/42406731034/eating-glue-or-how-to-parse-csv-like-a-pre-schooler),
It is no longer as up to date as the gem version but it does explain the **why** of it all.
