require_relative "../student"

describe "testing student" do
  context "protected method" do
    it "is not visible" do
      bob = Student.new("Bob")
      bob.grade = 50
      expect { bob.grade }.to raise_error(NoMethodError, /protected/)
    end

    it "shows better grade" do
      bob = Student.new("Bob")
      joe = Student.new("Joe")
      bob.grade = 85
      joe.grade = 90
      expect(bob.grade_better_than?(joe)).to eq(false)
      expect(joe.grade_better_than?(bob)).to eq(true)
    end
  end
end
