# frozen_string_literal: true

require 'curses'
require_relative '../board'

describe 'Board tests' do
  let(:mock_subwin) do
    instance_double(Curses::Window,
                    setpos: nil,
                    addch: nil)
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

  before do
    allow(Curses).to receive(:init_screen)
    allow(Curses).to receive(:close_screen)
    allow(Curses::Window).to receive(:new).and_return(mock_window)
    allow(Curses::Window).to receive(:subwin).and_return(mock_window)
  end

  def board_maker
    main_win = Curses::Window.new(Curses.lines, Curses.cols, 0, 0)
    side_size = 30
    Board.new(main_win, side_size)
  end

  context 'initialization tests' do
    # Should be a fake

    it 'should be initialized' do
      board = board_maker
      expect(board.winner).to eq(Board::IN_PROGRESS)
    end

    it 'x winner horiz' do
      board = board_maker
      board.set_tile_x(0, 0)
      expect(board.winner).to eq(Board::IN_PROGRESS)
      board.set_tile_x(0, 1)
      expect(board.winner).to eq(Board::IN_PROGRESS)
      board.set_tile_x(0, 2)
      expect(board.winner).to eq(Board::X_PLAYER)
    end

    it 'o winner vert' do
      board = board_maker
      board.set_tile_o(0, 0)
      expect(board.winner).to eq(Board::IN_PROGRESS)
      board.set_tile_o(1, 0)
      expect(board.winner).to eq(Board::IN_PROGRESS)
      board.set_tile_o(2, 0)
      expect(board.winner).to eq(Board::O_PLAYER)
    end

    it 'o winner diag' do
      board = board_maker
      board.set_tile_o(0, 0)
      expect(board.winner).to eq(Board::IN_PROGRESS)
      board.set_tile_o(1, 1)
      expect(board.winner).to eq(Board::IN_PROGRESS)
      board.set_tile_o(2, 2)
      expect(board.winner).to eq(Board::O_PLAYER)
    end

    it 'x winner diag' do
      board = board_maker
      board.set_tile_x(2, 0)
      expect(board.winner).to eq(Board::IN_PROGRESS)
      board.set_tile_x(1, 1)
      expect(board.winner).to eq(Board::IN_PROGRESS)
      board.set_tile_x(0, 2)
      expect(board.winner).to eq(Board::X_PLAYER)
    end
  end
end
