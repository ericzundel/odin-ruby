require_relative "../stock_picker"

describe "test stockpicker" do
  context "two days" do
    it "returns 0,1 for simple example" do
      expect(stock_picker([1, 10])).to eq([0, 1])
    end
    it "returns 0,1 for simple example" do
      expect(stock_picker([1, 10, 5])).to eq([0, 1])
    end
  end
  context "three days" do
    it "returns 0,2 for simple example" do
      expect(stock_picker([1, 5, 10])).to eq([0, 2])
    end
    it "returns 1,3 for simple example" do
      expect(stock_picker([11, 1, 5, 10])).to eq([1, 3])
    end
  end
end
