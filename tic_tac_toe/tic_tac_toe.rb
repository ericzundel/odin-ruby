# frozen_string_literal: true

require 'curses'

require './lib/board'
require './lib/screen'

def wait_for_input(main_win)
  main_win.setpos(Curses.lines - 1, 0)
  main_win.addstr('Thanks for playing! Press any key to exit.')
  main_win.refresh
  main_win.getch
end

def run_test_game(board)
  board.set_tile_o(0, 0)
  board.set_tile_x(1, 1)
  board.set_tile_o(0, 1)
  board.set_tile_x(2, 0)
  board.set_tile_o(0, 2)
  puts "Winner is #{board.winner}"
end

begin
  screen = Screen.new
  board = Board.new(screen)
  run_test_game(board) if !ARGV.empty? && ARGV[0] == 'test'
  board.next_player_turn while board.winner == Board::IN_PROGRESS
  wait_for_input(screen.main_win)
ensure
  screen.close
end
