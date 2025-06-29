# frozen_string_literal: true

# represents the pegs used in the game to denote a clue to which color pegs match the code
class CluePeg
  WHITE = 1
  BLACK = 2

  attr_reader :color

  def initialize(color)
    @color = color
  end
end
