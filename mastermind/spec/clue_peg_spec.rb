# frozen_string_literal: true

require_relative '../lib/clue_peg'

describe CluePeg do
  context 'when initialized' do
    it 'can be black' do
      peg = CluePeg.new(CluePeg::BLACK)
      expect(peg.color).to eq(CluePeg::BLACK)
    end
  end
end
