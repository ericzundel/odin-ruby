# See https://launchschool.com/books/oo_ruby/read/inheritance#exercises
#
#

module BedLength
  @bed_length = 0

  attr_accessor :bed_length
end

class Vehicle
  @@num_objects = 0

  attr_reader :year, :model, :speed
  attr_accessor :color

  def self.mpg(gallons, miles)
    return miles / gallons
  end

  def self.num_objects
    @@num_objects
  end

  def initialize(year, color, model)
    @@num_objects += 1

    @year = year
    @color = color
    @model = model
    @speed = 0
  end

  def increase_speed(n)
    @speed += n
  end

  def stop()
    @speed = 0
  end

  def decrease_speed(n)
    @speed -= n
    if @speed < 0
      self.stop()
    end
  end

  def spray_paint(color)
    @color = color
  end

  def to_s
    "Model: #{year} #{model} Color: #{color} @ #{speed}"
  end

  def age
    calc_age
  end

  private

  def calc_age
    this_year = Time.now.year
    return this_year - @year
  end
end

class MyCar < Vehicle
  COLOR = "Red"
  YEAR = 2025
  MODEL = "EX90"

  def initialize
    super(YEAR, COLOR, MODEL)
  end
end

class MyTruck < Vehicle
  COLOR = "Silver"
  YEAR = 2022
  MODEL = "Ridgeline"

  include BedLength

  def initialize
    super(YEAR, COLOR, MODEL)
  end
end
