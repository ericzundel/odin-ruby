# frozen_string_literal: true

require_relative '../lib/board'

describe Board do
  context 'when initialized' do
    it 'is unsolved' do
      board = Board.new(8)
      expect(board.solved?).to be(false)
    end
  end
end
