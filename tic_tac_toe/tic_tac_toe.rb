# frozen_string_literal: true

require 'curses'
require_relative './board'

def wait_for_input(main_win)
  main_win.keypad = true
  main_win.setpos(Curses.lines - 1, 0)
  main_win.addstr('Hello, Curses! Press any key to exit.')
  main_win.refresh
  main_win.getch
end

begin
  Curses.init_screen
  main_win = Curses::Window.new(Curses.lines, Curses.cols, 0, 0)
  side_size = [Curses.lines, Curses.cols].min
  board = Board.new(main_win, side_size)
  board.set_tile_o(0, 0)
  board.set_tile_x(1, 1)
  board.set_tile_o(0, 1)
  board.set_tile_x(2, 0)
  board.set_tile_o(0, 2)
  wait_for_input(main_win)
ensure
  Curses.close_screen
end
