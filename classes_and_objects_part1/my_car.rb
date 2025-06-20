class MyCar
  attr_reader :year, :model, :speed
  attr_accessor :color

  def initialize(year, color, model)
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
end
