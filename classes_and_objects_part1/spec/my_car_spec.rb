# frozen_string_literal: true

require_relative '../my_car'

describe 'test my_car' do
  context 'test1' do
    it 'returns initialized values' do
      my_car = MyCar.new(2025, 'Red', 'EX90')
      expect(my_car.color).to eq('Red')
      expect(my_car.speed).to eq(0)
      expect(my_car.model).to eq('EX90')
      expect(my_car.year).to eq(2025)
    end

    it 'allows modification' do
      my_car = MyCar.new(2025, 'Red', 'EX90')
      my_car.increase_speed(100)
      expect(my_car.speed).to eq(100)
      my_car.decrease_speed(15)
      expect(my_car.speed).to eq(85)
      my_car.stop
      expect(my_car.speed).to eq(0)
      my_car.spray_paint('yellow')
      expect(my_car.color).to eq('yellow')
    end
  end
end
