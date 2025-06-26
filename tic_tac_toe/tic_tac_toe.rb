# frozen_string_literal: true

require 'curses'

require './lib/board'
require './lib/screen'
require './lib/fireworks'

def wait_for_input(screen, message)
  screen.print_status("#{message} Thanks for playing! Press any key to exit.")
  sleep(3)
  screen.getch
end

def run_test1_game(screen, board)
  board.set_tile_o(0, 0)
  board.set_tile_x(1, 1)
  board.set_tile_o(0, 1)
  board.set_tile_x(2, 0)
  board.set_tile_o(0, 2)
  screen.refresh
end

def run_test2_game(screen, board)
  board.set_tile_o(0, 0)
  board.set_tile_x(1, 1)
  screen.refresh
end

begin
  
  screen = Screen.new
  board = Board.new(screen)

  # pass 'test1' on the commandline as an exercise for testing a complete game
  run_test1_game(screen, board) if !ARGV.empty? && ARGV[0] == 'test1'
  # pass 'test2' on the commandline to test a partial game
  run_test2_game(screen, board) if !ARGV.empty? && ARGV[0] == 'test2'

  board.next_player_turn while board.winner == Board::IN_PROGRESS

  message = ''
  if board.winner == Board::TIE
    message = 'It\'s a tie!'
  else
    # Display fireworks celebration
    fireworks = Fireworks.new(screen)
    player_name = board.winner == Board::X_PLAYER ? 'X' : 'O'
    fireworks.display_winner(player_name)
    message = "Congratulations #{player_name}!"
  end

  wait_for_input(screen, message)
ensure
  screen.close
end
