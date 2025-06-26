# frozen_string_literal: true

require 'curses'

require './lib/board'
require './lib/screen'

def wait_for_input(screen, message)
  screen.print_status("#{message} Thanks for playing! Press any key to exit.")
  sleep(3)
  screen.getch
end

def run_test_game(screen, board)
  board.set_tile_o(0, 0)
  board.set_tile_x(1, 1)
  board.set_tile_o(0, 1)
  board.set_tile_x(2, 0)
  board.set_tile_o(0, 2)
  screen.refresh
end

begin
  screen = Screen.new
  board = Board.new(screen)
  run_test_game(screen, board) if !ARGV.empty? && ARGV[0] == 'test'
  board.next_player_turn while board.winner == Board::IN_PROGRESS
  message = case board.winner
            when Board::X_PLAYER
              'X won!'
            when Board::O_PLAYER
              'O won!'
            else
              'Tie!'
            end

  wait_for_input(screen, message)
ensure
  screen.close
end
