# frozen_string_literal: true

# A colored peg that represents one digit of the code
class CodePeg
  RED = 1
  BLUE = 2
  PURPLE = 3
  GREEN = 4
  ORANGE = 5
  YELLOW = 6

  attr_reader :color

  def initialize(color)
    @color = color
  end
end
