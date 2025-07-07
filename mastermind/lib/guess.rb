# frozen_string_literal: true

require_relative 'code_peg'
require_relative 'clue_peg'

# Represents a row of pegs used as a guess
class Guess
  attr_reader :code_pegs

  def initialize(pegs = [])
    raise ArgumentError, "Expected 4 pegs, got #{code_pegs}" if pegs.length.positive? && pegs.length != 4

    @code_pegs = pegs
    @clue_pegs = []
  end

  def code_pegs=(code_pegs)
    raise ArgumentError, "Expected 4 pegs, got #{code_pegs}" if code_pegs.length != 4

    @code_pegs = code_pegs
  end
end
