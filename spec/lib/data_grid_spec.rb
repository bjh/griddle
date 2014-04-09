require 'spec_helper.rb'
require 'griddle'

describe Griddle::DataGrid do
  let(:grid) { Griddle::DataGrid.from_csv('data/po.csv') }

  describe '#find' do
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

  describe '#cut' do
    it 'returns a matrix/grid the size of the passed in parameters' do
      # data = grid.cut(11, 1, 1, 5)
      # expect(data.)
    end
  end
end
