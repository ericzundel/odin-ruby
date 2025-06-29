# frozen_string_literal: true

require_relative '../lib/code_peg'

describe CodePeg do
  context 'when initialized' do
    it 'can be red' do
      peg = CodePeg.new(CodePeg::RED)
      expect(peg.color).to eq(CodePeg::RED)
    end
  end
end
