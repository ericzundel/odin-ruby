require_relative "../my_car"

describe "test my_car" do
  context "Class Variables" do
    it "remembers number of instances" do
      expect(Vehicle.num_objects).to eq(0)
      my_car = MyCar.new
      expect(Vehicle.num_objects).to eq(1)
      my_truck = MyTruck.new
      expect(Vehicle.num_objects).to eq(2)
    end
  end

  context "test part1 exercises" do
    it "returns initialized values" do
      my_car = Vehicle.new(2025, "Red", "EX90")
      expect(my_car.color).to eq("Red")
      expect(my_car.speed).to eq(0)
      expect(my_car.model).to eq("EX90")
      expect(my_car.year).to eq(2025)
    end

    it "allows modification" do
      my_car = Vehicle.new(2025, "Red", "EX90")
      my_car.increase_speed(100)
      expect(my_car.speed).to eq(100)
      my_car.decrease_speed(15)
      expect(my_car.speed).to eq(85)
      my_car.stop
      expect(my_car.speed).to eq(0)
      my_car.spray_paint("yellow")
      expect(my_car.color).to eq("yellow")
    end
  end

  context "test part2 exercises" do
    it "calculates miles per gallon" do
      expect(MyCar.mpg(1, 10)).to eq(10)
      expect(MyCar.mpg(5, 100)).to eq(20)
    end

    it "pretty prints" do
      my_car = Vehicle.new(2025, "Red", "EX90")
      my_car.increase_speed(99)
      expect("#{my_car}").to eq("Model: 2025 EX90 Color: Red @ 99")
    end
  end

  context "test mycar overrides" do
    it "sets MyCar defaults" do
      my_car = MyCar.new
      expect(my_car.color).to eq("Red")
      expect(my_car.speed).to eq(0)
      expect(my_car.model).to eq("EX90")
      expect(my_car.year).to eq(2025)
    end

    it "sets MyTruck defaults" do
      my_truck = MyTruck.new
      expect(my_truck.color).to eq("Silver")
      expect(my_truck.speed).to eq(0)
      expect(my_truck.model).to eq("Ridgeline")
      expect(my_truck.year).to eq(2022)
    end
  end

  context "adding a mixin" do
    it "sets bed_length" do
      my_truck = MyTruck.new
      my_truck.bed_length = 6
      expect(my_truck.bed_length).to eq(6)
    end
  end

  context "show method lookup" do
    puts MyTruck.ancestors
  end

  context "calc age" do
    it "calculates age of truck" do
      my_truck = MyTruck.new
      expect(my_truck.age).to eq(3)
    end
  end
end
