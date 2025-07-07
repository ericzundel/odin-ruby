# frozen_string_literal: true

require 'curses'
require 'pry'

# This class holds all the curses state
# Note, you MUST call close before exiting if you want your terminal to return to normal
#
# begin
#   ui = CursesUi.new
#   ...
# ensure
#   ui.close
# end
#
class CursesUi
  RED_COLOR = 1
  BLUE_COLOR = 2
  PURPLE_COLOR = 3
  GREEN_COLOR = 4
  ORANGE_COLOR = 5
  YELLOW_COLOR = 6
  WHITE_COLOR = 7
  BLACK_COLOR = 8
  BACKGROUND_COLOR = 9

  def initialize(board)
    Curses.init_screen
    raise 'Make your terminal at least 28 x 80' if Curses.lines < 28 || Curses.cols < 80

    Curses.start_color
    @main_win = Curses::Window.new(Curses.lines, Curses.cols, 0, 0)
    @main_win.keypad = true
    print_status("Colors available: #{Curses.colors}")
    @board = board

    # :COLOR_BLACK 0
    # :COLOR_RED = 1
    # :COLOR_GREEN = 2
    # :COLOR_YELLOW = 3
    # :COLOR_BLUE  = 4
    # :COLOR_MAGENTA = 5
    # :COLOR_CYAN = 6
    # :COLOR_WHITE = 7
    # See https://en.wikipedia.org/wiki/ANSI_escape_code#Colors for those betyond 7
    Curses.init_pair(RED_COLOR, Curses::COLOR_RED, 8)
    Curses.init_pair(BLUE_COLOR, Curses::COLOR_BLUE, 8)
    Curses.init_pair(PURPLE_COLOR, Curses::COLOR_MAGENTA, 8)
    Curses.init_pair(GREEN_COLOR, Curses::COLOR_GREEN, 8)
    Curses.init_pair(ORANGE_COLOR, Curses::COLOR_CYAN, 8)
    Curses.init_pair(YELLOW_COLOR, Curses::COLOR_YELLOW, 8)
    Curses.init_pair(WHITE_COLOR, Curses::COLOR_WHITE, 8)
    Curses.init_pair(BLACK_COLOR, Curses::COLOR_BLACK, 8)
    Curses.init_pair(BACKGROUND_COLOR, 8, 8)

    getch
  end

  def print_status(status)
    @main_win.setpos(Curses.lines - 1, 0)
    @main_win.addstr(status)
    @main_win.clrtoeol
    @main_win.refresh
  end

  def getch
    @main_win.getch
  end

  def refresh
    @main_win.color_set(BACKGROUND_COLOR)
    @main_win.box
    @main_win.refresh
  end

  def close
    @main_win.close
  end
end
