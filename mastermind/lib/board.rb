# frozen_string_literal: true

require 'lib/secret_code'
require 'lib/row'

# Represents the game board with a configurable number of guesses
class Board
  def initialize(guesses)
    @guesses = guesses
    @secret_code = SecretCode.new
    @rows = []
    (0..guesses).each
  end

  def solved?
    guesses.each do |guess|
      return true if @secret_code.match?(guess)
    end
    false
  end
end
