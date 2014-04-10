require 'spec_helper.rb'
require 'griddle'

describe Griddle::DataGrid do
  let(:grid) { Griddle::DataGrid.from_csv('data/po.csv') }

  describe '#find' do
    context 'using a regular expression' do
      it 'uses the regexp to match against' do
        expect(grid.find(/ship to/i)).to have(1).item
      end
    end

    context 'when a single match is found' do
      it 'returns an array with a single Point' do
        expect(grid.find('SHIP TO')).to have(1).item
      end

      it 'the matched point has the row and column of the found item' do
        p = grid.find('SHIP TO').last
        expect(p.row).to eq 10
        expect(p.col).to eq 4
      end
    end

    context 'when multiple matches are found' do
      it 'returns an array of Points' do
        expect(grid.find('[Street Address]')).to have(3).items
      end
    end

    context 'when a match is NOT found' do
      it 'returns an empty array' do
        expect(grid.find('SHAZAM!!!')).to have(0).items
      end
    end
  end

  describe '#width' do
    it 'returns the width of the data grid' do
      r = grid.cut(11, 1, 1, 5).to_rectangle
      expect(r.width).to eq 1
    end
  end

  describe '#height' do
    it 'the height of the data grid' do
      r = grid.cut(11, 1, 1, 5).to_rectangle
      expect(r.height).to eq 5
    end
  end

  describe '#to_rectangle' do
    it 'returns a rectangle with the width and height of the data' do
      r = grid.cut(11, 1, 1, 5).to_rectangle
      expect(r.width).to eq 1
      expect(r.height).to eq 5
    end
  end

  describe '#cut' do
    it 'returns a matrix/grid the size of the passed in parameters' do
      data = grid.cut(11, 1, 1, 5)
      expect(data.grid).to have(5).items
    end
  end

  describe '#offset_up' do
    it 'adds one to every value passed in' do
      expect(grid.offset_up(4, 4)).to eq [5, 5]
    end
  end

  describe '#offset_down' do
    it 'subtract one from every value passed in' do
      expect(grid.offset_down(4, 4)).to eq [3, 3]
    end
  end
end
