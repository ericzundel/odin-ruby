# frozen_string_literal: true

require_relative 'secret_code'
require_relative 'guess'

# Represents the game board with a configurable number of guesses
class Board
  # num_guesses - the number of guesses to store
  def initialize(num_guesses = 12, secret_code = nil)
    @secret_code = if secret_code.nil?
                     SecretCode.new
                   else
                     secret_code
                   end
    @guesses = []
    (0..num_guesses).each do |_|
      @guesses.push(Guess.new)
    end
  end

  def solved?
    @guesses.each do |guess|
      return true if @secret_code.match?(guess)
    end
    false
  end
end
