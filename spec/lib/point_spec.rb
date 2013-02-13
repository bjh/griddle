require_relative '../spec_helper.rb'
require_relative '../../lib/point.rb'

describe Griddle::Point do
  describe "#move" do
    let(:point) { Griddle::Point.new(10, 10) }

    it "moves a point :up" do
      point.move(up: 2)
      expect(point.row).to eq(8)
    end

    it "moves a point :down" do
      point.move(:down => 4)
      expect(point.row).to eq(14)
    end

    it "moves a point :up and :right" do
      point.move(up:5, right:3)
      expect(point.row).to eq(5)
      expect(point.col).to eq(13)
    end
  end
end

