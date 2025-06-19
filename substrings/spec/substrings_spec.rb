require_relative "../substrings"

describe "test substrings" do
  context "single search string" do
    it "returns 1 for start of string" do
      expect(substrings("hello world", ["hell"])).to eq({ "hell": 1 })
    end
    it "returns 1 for end of string" do
      expect(substrings("hello world", ["orld"])).to eq({ "orld": 1 })
    end

    it "returns 1 for middle of string" do
      expect(substrings("hello world", ["llo"])).to eq({ "llo": 1 })
    end

    it "returns multiple" do
      expect(substrings("hello world", ["l"])).to eq({ "l": 3 })
    end
  end

  context "multiple search strings" do
    it "returns multiple" do
      expect(substrings("hello world", ["hell", "orld", "llo", "l"])).to eq({ "hell": 1, "orld": 1, "llo": 1, "l": 3 })
    end
  end
end
