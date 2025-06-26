# frozen_string_literal: true

require 'curses'
require_relative '../lib/board'

describe Board do
  let(:mock_subwin) do
    instance_double(Curses::Window,
                    setpos: nil,
                    addch: nil,
                    refresh: nil)
  end

  let(:mock_window) do
    instance_double(Curses::Window,
                    setpos: nil,
                    addstr: nil,
                    addch: nil,
                    refresh: nil,
                    getch: nil,
                    close: nil,
                    subwin: mock_subwin)
  end

  let(:mock_screen) do
    instance_double(Screen,
                    main_win: mock_window,
                    side_size: 30)
  end

  let(:board) do
    Board.new(mock_screen)
  end

  before do
    allow(Curses).to receive(:init_screen)
    allow(Curses).to receive(:close_screen)
    allow(Curses::Window).to receive_messages({ new: mock_window, subwin: mock_window })
  end

  context 'when freshly initialized' do
    # Should be a fake

    it 'is initialized' do
      expect(board.winner).to eq(Board::IN_PROGRESS)
    end

    it 'x winner horiz' do
      board.set_tile_x(0, 0)
      board.set_tile_x(0, 1)
      expect(board.winner).to eq(Board::IN_PROGRESS)
      board.set_tile_x(0, 2)
      expect(board.winner).to eq(Board::X_PLAYER)
    end

    it 'o winner vert' do
      board.set_tile_o(0, 2)
      board.set_tile_o(1, 2)
      expect(board.winner).to eq(Board::IN_PROGRESS)
      board.set_tile_o(2, 2)
      expect(board.winner).to eq(Board::O_PLAYER)
    end

    it 'o winner diag' do
      board.set_tile_o(0, 0)
      board.set_tile_o(1, 1)
      expect(board.winner).to eq(Board::IN_PROGRESS)
      board.set_tile_o(2, 2)
      expect(board.winner).to eq(Board::O_PLAYER)
    end

    it 'x winner diag' do
      board.set_tile_x(2, 0)
      board.set_tile_x(1, 1)
      expect(board.winner).to eq(Board::IN_PROGRESS)
      board.set_tile_x(0, 2)
      expect(board.winner).to eq(Board::X_PLAYER)
    end
  end
end
