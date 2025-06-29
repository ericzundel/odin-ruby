# rubocop:disable Style/FrozenStringLiteralComment

require 'code_peg'
require 'clue_peg'
require 'guess'
require 'secret_code'

describe SecretCode do
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

  context 'when initialized with no pegs' do
    it 'does not crash' do
      code = SecretCode.new
      code.match?(good_guess_for_code1)
      expect(code.clue_pegs(good_guess_for_code1).length).to be <= 4
    end
  end

  context 'when same order' do
    it 'matches a guess' do
      expect(code1.match?(good_guess_for_code1)).to be(true)
    end

    it 'returns proper clue pegs' do
      clue_pegs = code1.clue_pegs(good_guess_for_code1)
      expect(clue_pegs.length).to eq(4)
      expect(clue_pegs[0].color).to eq(CluePeg::BLACK)
      expect(clue_pegs[1].color).to eq(CluePeg::BLACK)
      expect(clue_pegs[2].color).to eq(CluePeg::BLACK)
      expect(clue_pegs[3].color).to eq(CluePeg::BLACK)
    end
  end

  context 'when different order' do
    it "doesn't match a guess" do
      expect(code1.match?(close_guess_for_code1)).to be(false)
    end

    it 'returns proper clue pegs' do
      clue_pegs = code1.clue_pegs(close_guess_for_code1)
      expect(clue_pegs.length).to eq(4)
      expect(clue_pegs[0].color).to eq(CluePeg::BLACK)
      expect(clue_pegs[1].color).to eq(CluePeg::BLACK)
      expect(clue_pegs[2].color).to eq(CluePeg::WHITE)
      expect(clue_pegs[3].color).to eq(CluePeg::WHITE)
    end
  end
end
