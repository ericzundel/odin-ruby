# frozen_string_literal: true

require 'set'

require 'code_peg'

# Stores the 4 peg secret code
class SecretCode
  def initialize(pegs = nil)
    @code = []
    if pegs.nil?
      (0..4).each do |_|
        @code.push(CodePeg.new(rand(1..6)))
      end
    else
      # For testing, we want to specify the pegs for the code
      raise ArgumentError unless pegs.length == 4

      @code = pegs
    end
  end

  def match?(guess)
    guess.code_pegs == @code
  end

  def clue_pegs(guess)
    black_pegs = []
    white_pegs = []
    unmatched_code = []
    unmatched_guesses = []

    # Figure out the exact matches
    (0..3).each do |pos|
      code_peg = @code[pos]
      guess_peg = guess.code_pegs[pos]
      if code_peg.color == guess_peg.color
        black_pegs.push(CluePeg.new(CluePeg::BLACK))
      else
        unmatched_code.push(code_peg.color)
        unmatched_guesses.push(guess_peg.color)
      end
    end

    unmatched_guesses.each do |guess_peg_color|
      if unmatched_code.include?(guess_peg_color)
        white_pegs.push(CluePeg.new(CluePeg::WHITE))
        unmatched_code.delete_at(unmatched_code.index(guess_peg_color)) if unmatched_code.include?(guess_peg_color)
      end
    end
    [black_pegs, white_pegs].flatten
  end
end
