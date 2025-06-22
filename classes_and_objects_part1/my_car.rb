# frozen_string_literal: true

# See https://launchschool.com/books/oo_ruby/read/classes_and_objects_part1
#
class MyCar
  attr_reader :year, :model, :speed
  attr_accessor :color

  def initialize(year, color, model)
    @year = year
    @color = color
    @model = model
    @speed = 0
  end

  def increase_speed(value)
    @speed += value
  end

  def stop
    @speed = 0
  end

  def decrease_speed(value)
    @speed -= value
    return unless @speed.negative?

    stop
  end

  def spray_paint(color)
    @color = color
  end
end
