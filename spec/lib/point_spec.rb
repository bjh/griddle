require 'spec_helper.rb'
require 'griddle'

describe Griddle::Point do
  let(:point) { Griddle::Point.new(10, 10) }

  describe '#delta' do
    context 'when the points have the same values' do
      it 'returns a point with [0,0]' do
        p2 = Griddle::Point.new(10, 10)
        expect(point.delta(p2).zero?).to be_true
      end
    end

    context 'when the points have the different values' do
      it 'returns a point with the difference' do
        p2 = Griddle::Point.new(3, 3)
        expect(point.delta(p2)).to eq Griddle::Point.new(7, 7)
      end
    end
  end

  # make sure the spaceship was implemented properly
  describe '<=>' do
    context 'when lhs == rhs' do
      it 'returns true' do
        rhs = Griddle::Point.new(10, 10)
        expect(point == rhs).to be_true
      end
    end

    context 'when lhs > rhs' do
      it 'returns true' do
        rhs = Griddle::Point.new(9, 0)
        expect(point > rhs).to be_true
      end
    end

    context 'when lhs < rhs' do
      it 'returns true' do
        rhs = Griddle::Point.new(11, 11)
        expect(point < rhs).to be_true
      end
    end
  end

  describe 'movement methods' do
    it 'can go up' do
      expect(point).to respond_to :up
    end

    it 'can go down' do
      expect(point).to respond_to :down
    end

    it 'can go left' do
      expect(point).to respond_to :left
    end

    it 'can go right' do
      expect(point).to respond_to :right
    end

    describe "#move" do
      it "moves up" do
        point.move(up: 2)
        expect(point.row).to eq(8)
      end

      it "moves down" do
        point.move(:down => 4)
        expect(point.row).to eq(14)
      end

      it "moves up and right" do
        point.move(up:5, right:3)
        expect(point.row).to eq(5)
        expect(point.col).to eq(13)
      end
    end
  end
end
