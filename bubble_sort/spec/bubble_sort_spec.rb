require_relative "../bubble_sort"

describe "test bubble_sort" do
  context "test1" do
    it "returns sorted" do
      list = [0, 1, 2, 3, 4, 5, 10, 6, 9, 8]
      expect(bubble_sort(list)).to eq(list.sort)
    end
  end
  context "test2" do
    it "returns sorted" do
      list = [0, 1, 2, 3, 4, 5]
      expect(bubble_sort(list)).to eq(list.sort)
    end
  end
  context "test3" do
    it "returns sorted" do
      list = [1, 0]
      expect(bubble_sort(list)).to eq(list.sort)
    end
  end
  context "test4" do
    it "returns sorted" do
      list = [1]
      expect(bubble_sort(list)).to eq(list.sort)
    end
  end

  context "test5" do
    it "returns sorted" do
      list = [9, 8, 7, 6, 5, 4, 3, 2, 1]
      expect(bubble_sort(list)).to eq(list.sort)
    end
  end
end
