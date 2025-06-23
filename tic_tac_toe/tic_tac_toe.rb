# frozen_string_literal: true

require 'curses'
require_relative './board'

def wait_for_input
  main_win.keypad = true
  main_win.setpos(Curses.lines - 1, 0)
  main_win.addstr('Hello, Curses! Press any key to exit.')
  main_win.refresh
  main_win.getch
end

def init
  Curses.init_screen
  main_win = Curses::Window.new(Curses.lines, Curses.cols, 0, 0)
  side_size = [Curses.lines, Curses.cols].min

  board = Board.new(main_win, side_size)
end

begin
  init
  wait_for_input
ensure
  Curses.close_screen
end
