# frozen_string_literal: true

require_relative '../lib/guess'

describe Guess do
  let(:blue_peg) do
    CodePeg.new(CodePeg::BLUE)
  end
  let(:red_peg) do
    CodePeg.new(CodePeg::RED)
  end
  let(:green_peg) do
    CodePeg.new(CodePeg::GREEN)
  end
  let(:yellow_peg) do
    CodePeg.new(CodePeg::YELLOW)
  end
  let(:code1) do
    SecretCode.new([blue_peg, red_peg, green_peg, yellow_peg])
  end
  let(:good_guess_for_code1) do
    Guess.new([blue_peg, red_peg, green_peg, yellow_peg])
  end
  let(:close_guess_for_code1) do
    Guess.new([yellow_peg, red_peg, green_peg, blue_peg])
  end

  context 'when initialized' do
    it 'must have 4 pegs' do
      expect { Guess.new([yellow_peg, red_peg, green_peg, blue_peg, yellow_peg]) }.to raise_error(ArgumentError)
      expect { Guess.new([green_peg, blue_peg, yellow_peg]) }.to raise_error(ArgumentError)
    end

    it 'is ok with no pegs' do
      guess = Guess.new
      expect(guess.code_pegs).to eq([])
    end
  end

  context 'when initialized with no pegs' do
    it 'allows assigning pegs' do
      guess = Guess.new
      guess.code_pegs = [yellow_peg, red_peg, green_peg, blue_peg]
    end
  end
end
